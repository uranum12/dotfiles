cmake_minimum_required(VERSION 3.15)
project(tools CXX)

find_package(argparse REQUIRED)
find_package(SQLiteCpp REQUIRED)

add_executable(zhist src/zhist.cpp)
target_compile_features(zhist PRIVATE cxx_std_17)
target_link_libraries(zhist PRIVATE argparse::argparse SQLiteCpp)

install(TARGETS zhist RUNTIME DESTINATION bin)
