#include "zprompt.hpp"

#include <string>

#include <fmt/color.h>
#include <fmt/core.h>

namespace {

constexpr auto color_success = fmt::fg(fmt::terminal_color::green);
constexpr auto color_failure = fmt::fg(fmt::terminal_color::red);

}  // namespace

std::string get_return_code(int return_code) {
    return return_code == 0
               ? fmt::format(color_success, "❯ ")
               : fmt::format(color_failure, "({}) ❯ ", return_code);
}
