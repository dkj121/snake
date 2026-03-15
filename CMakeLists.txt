cmake_minimum_required(VERSION 3.16)

project(snake VERSION 1.0 LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Quick Core)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appsnake
    main.cpp
)

file(GLOB_RECURSE WEBM_FILES CONFIGURE_DEPENDS "Assets/*.gif")
foreach(file ${WEBM_FILES})
    file(RELATIVE_PATH relpath ${CMAKE_CURRENT_SOURCE_DIR} ${file})
    set_source_files_properties(${file} PROPERTIES QT_RESOURCE_ALIAS "/${relpath}")
endforeach()

qt_add_qml_module(appsnake
    URI snake
    VERSION 1.0
    QML_FILES
        Main.qml
        snake.qml
    RESOURCES
        ${WEBM_FILES}
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appsnake PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appsnake
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE OFF
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
