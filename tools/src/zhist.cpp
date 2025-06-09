#include <chrono>
#include <exception>
#include <filesystem>
#include <iostream>
#include <stdexcept>
#include <string>

#include <SQLiteCpp/SQLiteCpp.h>
#include <argparse/argparse.hpp>

namespace fs = std::filesystem;

constexpr auto sql_db_init = R"sql(
    CREATE TABLE IF NOT EXISTS histories (
        id INTEGER PRIMARY KEY,
        command TEXT NOT NULL,
        directory TEXT,
        return_code INTEGER,
        time INTEGER NOT NULL,
        UNIQUE(command, directory, return_code)
    );
    CREATE INDEX IF NOT EXISTS idx_filter ON histories(return_code, directory, time);
)sql";

constexpr auto sql_insert = R"sql(
    INSERT OR REPLACE INTO histories (command, directory, return_code, time)
    VALUES (?, ?, ?, ?)
)sql";

fs::path home_dir() {
    const char *home = std::getenv("HOME");
    if (home == nullptr) {
        throw std::runtime_error("can't get HOME");
    }
    return fs::path(home);
}

void init(const fs::path &db_dir, const fs::path &db_path) {
    if (!fs::exists(db_dir)) {
        fs::create_directory(db_dir);
    }
    SQLite::Database db(db_path, SQLite::OPEN_READWRITE | SQLite::OPEN_CREATE);
    db.exec(sql_db_init);
}

void add(const fs::path &db_path, const std::string &cmd,
         const std::string &dir, int code) {
    auto pos = cmd.find_first_not_of(" \t\n\v\f\r");
    if (pos == std::string::npos || cmd[pos] == '#') {
        return;
    }

    auto now = std::chrono::system_clock::now();
    auto time = std::chrono::duration_cast<std::chrono::milliseconds>(
                    now.time_since_epoch())
                    .count();

    auto db = SQLite::Database(db_path, SQLite::OPEN_READWRITE);

    SQLite::Statement insert(db, sql_insert);
    insert.bind(1, cmd);
    insert.bind(2, dir);
    insert.bind(3, code);
    insert.bind(4, time);
    insert.exec();
}

int main(int argc, char *argv[]) {
    argparse::ArgumentParser program("zhist");
    program.add_description("history command using sqlite");

    argparse::ArgumentParser init_command("init");
    init_command.add_description("initialize database");

    argparse::ArgumentParser add_command("add");
    add_command.add_description("add history to database");
    add_command.add_argument("-c", "--command").help("command").required();
    add_command.add_argument("-d", "--directory").help("directory").required();
    add_command.add_argument("-r", "--return-code")
        .help("return code")
        .scan<'i', int>()
        .required();

    argparse::ArgumentParser list_command("list");
    list_command.add_description("list history");
    auto &return_code_group = list_command.add_mutually_exclusive_group(false);
    return_code_group.add_argument("-r", "--return-code")
        .help("return code")
        .scan<'i', int>();
    return_code_group.add_argument("-s", "--only-success")
        .help("filter return code is success")
        .default_value(false)
        .implicit_value(true);
    ;
    return_code_group.add_argument("-f", "--only-failure")
        .help("filter return code is failure")
        .default_value(false)
        .implicit_value(true);
    ;
    auto &directory_group = list_command.add_mutually_exclusive_group(false);
    directory_group.add_argument("-d", "--directory").help("directory");
    directory_group.add_argument("-c", "--current-directory")
        .help("current directory")
        .default_value(false)
        .implicit_value(true);

    program.add_subparser(init_command);
    program.add_subparser(add_command);
    program.add_subparser(list_command);

    try {
        program.parse_args(argc, argv);
    } catch (const std::exception &err) {
        std::cerr << err.what() << std::endl;
        std::cerr << program;
        return 1;
    }

    auto db_dir = home_dir() / ".local/share/zhist";
    auto db_path = db_dir / "zhist.db";

    if (program.is_subcommand_used("init")) {
        init(db_dir, db_path);

        return 0;
    }

    if (program.is_subcommand_used("add")) {
        auto cmd = add_command.get<std::string>("--command");
        auto dir = add_command.get<std::string>("--directory");
        auto ret = add_command.get<int>("--return-code");

        try {
            add(db_path, cmd, dir, ret);
        } catch (const std::exception &e) {
            std::cerr << e.what();
            return 1;
        }

        return 0;
    }

    if (program.is_subcommand_used("list")) {
        if (auto ret = list_command.present<int>("--return-code")) {
            std::cout << "return code: " << *ret << std::endl;
        } else if (list_command.get<bool>("--only-success")) {
            std::cout << "only success" << std::endl;
        } else if (list_command.get<bool>("--only-failure")) {
            std::cout << "only failure" << std::endl;
        } else {
            std::cout << "all return code" << std::endl;
        }

        if (auto dir = list_command.present<std::string>("--directory")) {
            std::cout << "directory: " << *dir << std::endl;
        } else if (list_command.get<bool>("--current-directory")) {
            std::cout << "current directory" << std::endl;
        } else {
            std::cout << "all directory" << std::endl;
        }

        return 0;
    }

    std::cerr << program;
    return 1;
}
