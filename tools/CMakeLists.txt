cmake_minimum_required(VERSION 3.11)
project("tools" C CXX)

include(FetchContent)

fetchcontent_declare(argparse
                     GIT_REPOSITORY https://github.com/p-ranav/argparse.git)
fetchcontent_makeavailable(argparse)

set(SQLITECPP_INSTALL OFF)
fetchcontent_populate(
    sqlitecpp
    GIT_REPOSITORY https://github.com/SRombauts/SQLiteCpp.git
    GIT_TAG 3.3.3)
add_subdirectory(${sqlitecpp_SOURCE_DIR})

add_executable(zhist src/zhist.cpp)
target_compile_features(zhist PRIVATE cxx_std_20)
target_link_libraries(zhist PRIVATE argparse SQLiteCpp sqlite3 pthread dl)

install(TARGETS zhist RUNTIME DESTINATION bin)
