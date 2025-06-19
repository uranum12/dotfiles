#include "zprompt.hpp"

#include <algorithm>
#include <array>
#include <cstdlib>
#include <cstring>
#include <filesystem>
#include <string>

namespace fs = std::filesystem;

namespace {

constexpr auto color_anchor = Color::magenta;
constexpr auto color_normal = Color::blue;

constexpr auto pwd_markers = std::to_array({
    ".git",
    ".svn",
    ".node-version",
    ".python-version",
    ".tool-versions",
    "Cargo.toml",
    "go.mod",
    "package.json",
});

bool has_marker(const fs::path& dir) {
    return std::ranges::any_of(pwd_markers, [&](const char* marker) {
        return fs::exists(dir / marker);
    });
}

std::string format_path() {
    std::string result;
    auto current_path = fs::current_path();
    auto accumulated_path = current_path.root_directory();

    for (const auto& part : current_path) {
        if (part == accumulated_path) {
            result = color_wrap(color_normal, "/");
            continue;
        }

        accumulated_path /= part;

        if (has_marker(accumulated_path)) {
            result += color_wrap(color_normal, "/") +
                      color_wrap(color_anchor, part.string());
        } else {
            result += color_wrap(color_normal, "/" + part.string());
        }
    }

    return result;
}

std::string format_path(const fs::path& home_path) {
    std::string result;
    auto current_path = fs::current_path();
    auto accumulated_path = current_path.root_directory();

    for (const auto& part : current_path) {
        if (part == accumulated_path) {
            result = color_wrap(color_normal, "/");
            continue;
        }

        accumulated_path /= part;

        if (accumulated_path == home_path) {
            result = color_wrap(color_normal, "~");
        } else if (has_marker(accumulated_path)) {
            result += color_wrap(color_normal, "/") +
                      color_wrap(color_anchor, part.string());
        } else {
            result += color_wrap(color_normal, "/" + part.string());
        }
    }

    return result;
}

}  // namespace

std::string get_current_directory() {
    const auto* home_env = getenv("HOME");
    if (home_env != nullptr && strlen(home_env) > 0) {
        auto home_path = fs::path(home_env);
        return format_path(home_path);
    }
    return format_path();
}
