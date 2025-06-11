project(
    'tools',
    'cpp',
    default_options: [
        'cpp_std=c++20',
        'warning_level=3',
        'default_library=static',
    ],
)

argparse_dep = dependency('argparse', fallback: ['argparse', 'argparse_dep'])
sqlitecpp_dep = dependency('sqlitecpp', fallback: ['sqlitecpp', 'sqlitecpp_dep'])

executable(
    'zhist',
    ['src/zhist.cpp'],
    dependencies: [argparse_dep, sqlitecpp_dep],
    install: true,
)
