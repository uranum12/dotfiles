#ifndef ZPROMPT_HPP
#define ZPROMPT_HPP

#include <string>

std::string get_current_directory();
std::string get_git_status();
std::string get_ssh_status();
std::string get_venv_status();
std::string get_return_code(int return_code);

#endif /* end of include guard: ZPROMPT_HPP */
