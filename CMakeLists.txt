cmake_minimum_required(VERSION 3.6)

#set project name and language
project(vf-metaproject LANGUAGES CXX)

#Automoc and RCC ON. Needed in QT projects
#set(CMAKE_AUTOMOC ON)
#set(CMAKE_AUTORCC ON)
#C++ 11 Flag
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)




include(ZeraSuperBuild.cmake)

#activate QML Debugging if build type is Debug
if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    message(STATUS "QML Debugging is enabled. Please use this build only in a dafe environment")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DQT_QML_DEBUG -DQT_DECLARATIVE_DEBUG")
endif()


set(name JsonSettingsQml)
set(path api)
set(deps)
add_sub_project_deps(${name} ${path} "deps")


set(name vf-gui-translation)
set(path api)
set(deps)
add_sub_project_deps(${name} ${path} "deps")


set(name SortFilterProxyModelCmake)
set(path api)
set(deps)
add_sub_project_deps(${name} ${path} "deps")


set(name helpers)
set(path utils)
set(deps)
add_sub_project_deps(${name} ${path} "deps")


set(name zvkeyboard)
set(path api)
set(deps)
add_sub_project_deps(${name} ${path} "deps")


set(name vf-tcp)
set(path transport)
set(deps helpers)
add_sub_project_deps(${name} ${path} "deps")


set(name vf-crypto-bridge)
set(path utils)
set(deps helpers vf-tcp)
add_sub_project_deps(${name} ${path} "deps")


set(name vf-event)
set(path processing)
set(deps helpers vf-tcp)
add_sub_project_deps(${name} ${path} "deps")


set(name vf-component)
set(path processing)
set(deps helpers vf-tcp vf-event)
add_sub_project_deps(${name} ${path} "deps")


set(name vf-storage-hash)
set(path storage)
set(deps vf-component vf-event helpers)
add_sub_project_deps(${name} ${path} "deps")


set(name vf-net2)
set(path transport)
set(deps vf-tcp helpers vf-component vf-event)
add_sub_project_deps(${name} ${path} "deps")


set(name vf-protobuf)
set(path transport)
add_sub_project_deps(${name} ${path} "deps")


set(name vf-qml)
set(path api)
set(deps vf-protobuf vf-net2 helpers vf-event)
add_sub_project_deps(${name} ${path} "deps")


set(name vf-cpp)
set(path api)
set(deps vf-component helpers vf-event)
add_sub_project_deps(${name} ${path} "deps")


set(name vf-qmllibs)
set(path api)
set(deps SortFilterProxyModelCmake JsonSettingsQml vf-gui-translation)
add_sub_project_deps(${name} ${path} "deps")


set(name vf-script)
set(path processing)
set(deps vf-protobuf vf-net2 helpers vf-event vf-qml vf-storage-hash)
add_sub_project_deps(${name} ${path} "deps")


set(name vf-logger)
set(path processing)
set(deps vf-tcp helpers vf-component vf-event vf-qml vf-storage-hash)
add_sub_project_deps(${name} ${path} "deps")


set(name PythonScriptingInterface)
set(path api)
set(deps )
add_sub_project_deps(${name} ${path} "deps")


set(name vf-export)
set(path processing)
set(deps vf-cpp PythonScriptingInterface helpers vf-component vf-event vf-logger)
add_sub_project_deps(${name} ${path} "deps")


set(name vf-files)
set(path processing)
set(deps vf-cpp)
add_sub_project_deps(${name} ${path} "deps")


set(name vf-database-recorder)
set(path utils)
set(deps vf-tcp helpers vf-component vf-event vf-logger)
add_sub_project_deps(${name} ${path} "deps")


set(name vf-database-replay)
set(path utils)
set(deps vf-tcp helpers vf-component vf-event vf-logger)
add_sub_project_deps(${name} ${path} "deps")


set(name  debugger)
set(path utils)
set(deps vf-tcp helpers vf-component vf-event vf-logger)
add_sub_project_deps(${name} ${path} "deps")


set(name vf-unittest2)
set(path utils)
set(deps vf-tcp helpers vf-component vf-event vf-logger)
add_sub_project_deps(${name} ${path} "deps")


set(name vf-declarative-gui)
set(path guis)
set(deps vf-tcp vf-gui-translation helpers vf-component vf-event vf-logger vf-qmllibs)
add_sub_project_deps(${name} ${path} "deps")


set(name zera-setup2)
set(path guis)
set(deps vf-tcp helpers vf-component vf-event vf-logger)
add_sub_project_deps(${name} ${path} "deps")


