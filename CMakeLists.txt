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


option(build_helpers "activate or deactivate build" ON)
option(build_vf-tcp "activate or deactivate build" ON)
option(build_xiqnet "activate or deactivate build" ON)
option(build_vf-crypto-bridge "activate or deactivate build" ON)
option(build_vf-event "activate or deactivate build" ON)
option(build_vf-component "activate or deactivate build" ON)
option(build_vf-storage-hash "activate or deactivate build" ON)
option(build_vf-net2 "activate or deactivate build" ON)
option(build_vf-protobuf "activate or deactivate build" ON)
option(build_vf-qml "activate or deactivate build" ON)
option(build_vf-script "activate or deactivate build" ON)
option(build_vf-logger "activate or deactivate build" ON)
option(build_vf-database-recorder "activate or deactivate build" ON)
option(build_vf-database-replay "activate or deactivate build" ON)
option(build_debugger "activate or deactivate build" ON)
option(build_vf-unittest2 "activate or deactivate build" ON)
option(build_vf-declarative-gui "activate or deactivate build" ON)
option(build_zera-setup2 "activate or deactivate build" ON)

#activate QML Debugging if build type is Debug
if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    message(STATUS "QML Debugging is enabled. Please use this build only in a dafe environment")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DQT_QML_DEBUG -DQT_DECLARATIVE_DEBUG")
endif()



#Project vf-helpers
set(name helpers)
set(path utils)
set(deps )
if(${build_${name}})
    add_sub_project(${name} ${path})
endif()

#project vf-tcp
set(name vf-tcp)
set(path transport)
set(deps helpers)
if(${build_${name}})
    add_sub_project_deps(${name} ${path} "deps")
endif()

#project xiqnet
set(name xiqnet)
set(path transport)
set(deps helpers)
if(${build_${name}})
    add_sub_project_deps(${name} ${path} "deps")
endif()

#project vf-crypto-bridge
set(name vf-crypto-bridge)
set(path utils)
set(deps helpers vf-tcp)
if(${build_${name}})
    add_sub_project_deps(${name} ${path} "deps")
endif()

#project vf-event
set(name vf-event)
set(path processing)
set(deps helpers vf-tcp)
if(${build_${name}})
    add_sub_project_deps(${name} ${path} "deps")
endif()

#project vf-component
set(name vf-component)
set(path processing)
set(deps helpers vf-tcp vf-event)
if(${build_${name}})
    add_sub_project_deps(${name} ${path} "deps")
endif()

#project vf-storage-hash
set(name vf-storage-hash)
set(path storage)
set(deps vf-component vf-event helpers)
if(${build_${name}})
    add_sub_project_deps(${name} ${path} "deps")
endif()

#project vf-net2
set(name vf-net2)
set(path transport)
set(deps vf-tcp helpers vf-component vf-event)
if(${build_${name}})
    add_sub_project_deps(${name} ${path} "deps")
endif()


#project vf-protobuf
set(name vf-protobuf)
set(path transport)
if(${build_${name}})
    add_sub_project(${name} ${path})
endif()

#project vf-qml
set(name vf-qml)
set(path api)
set(deps vf-protobuf vf-net2 helpers vf-event)
if(${build_${name}})
    add_sub_project_deps(${name} ${path} "deps")
endif()

#project vf-script
set(name vf-script)
set(path processing)
set(deps vf-protobuf vf-net2 helpers vf-event vf-qml)
if(${build_${name}})
    add_sub_project_deps(${name} ${path} "deps")
endif()

#project vf-logger
set(name vf-logger)
set(path processing)
set(deps vf-tcp helpers vf-component vf-event vf-qml vf-storage-hash)
if(${build_${name}})
    add_sub_project_deps(${name} ${path} "deps")
endif()

#project vf-database-recorder
set(name vf-database-recorder)
set(path utils)
set(deps vf-tcp helpers vf-component vf-event vf-logger)
if(${build_${name}})
    add_sub_project_deps(${name} ${path} "deps")
endif()

#project vf-database-replay
set(name vf-database-replay)
set(path utils)
set(deps vf-tcp helpers vf-component vf-event vf-logger)
if(${build_${name}})
    add_sub_project_deps(${name} ${path} "deps")
endif()

#project debugger
set(name  debugger)
set(path utils)
set(deps vf-tcp helpers vf-component vf-event vf-logger)
if(${build_${name}})
    add_sub_project_deps(${name} ${path} "deps")
endif()

#project vf-unittest2
set(name vf-unittest2)
set(path utils)
set(deps vf-tcp helpers vf-component vf-event vf-logger)
if(${build_${name}})
    add_sub_project_deps(${name} ${path} "deps")
endif()

#project vf-declarative-gui
set(name vf-declarative-gui)
set(path guis)
set(deps vf-tcp helpers vf-component vf-event vf-logger)
if(${build_${name}})
    add_sub_project_deps(${name} ${path} "deps")
endif()

#project zera-setup2
set(name zera-setup2)
set(path guis)
set(deps vf-tcp helpers vf-component vf-event vf-logger)
if(${build_${name}})
    add_sub_project_deps(${name} ${path} "deps")
endif()


