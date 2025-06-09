#include <iostream>

#include <SQLiteCpp/SQLiteCpp.h>
#include <argparse/argparse.hpp>

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

    if (program.is_subcommand_used("init")) {
        std::cout << "init" << std::endl;

        return 0;
    }

    if (program.is_subcommand_used("add")) {
        auto cmd = add_command.get<std::string>("--command");
        auto dir = add_command.get<std::string>("--directory");
        auto ret = add_command.get<int>("--return-code");
        std::cout << "cmd: " << cmd << std::endl;
        std::cout << "dir: " << dir << std::endl;
        std::cout << "ret: " << ret << std::endl;

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
