cmake_minimum_required(VERSION 3.16)

project(snake VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Core)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appsnake
    main.cpp
)

qt_add_qml_module(appsnake
    URI snake
    VERSION 1.0
    QML_FILES
        Main.qml
        snake.qml
    RESOURCES
        ./Assets/Eternal-Ceremony/Interact.webm
        ./Assets/Eternal-Ceremony/Relax.webm
        ./Assets/Eternal-Ceremony/Move.webm
        ./Assets/Eternal-Ceremony/Sit.webm
        ./Assets/Eternal-Ceremony/Sleep.webm
        ./Assets/Eternal-Ceremony/Special.webm
        ./Assets/Influences-Through-the-Ages/Interact.webm
        ./Assets/Influences-Through-the-Ages/Relax.webm
        ./Assets/Influences-Through-the-Ages/Move.webm
        ./Assets/Influences-Through-the-Ages/Sit.webm
        ./Assets/Influences-Through-the-Ages/Sleep.webm
        ./Assets/Influences-Through-the-Ages/Special.webm
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appsnake PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appsnake
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appsnake
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appsnake
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
