cmake_minimum_required(VERSION 3.6)

#set project name and language
project(vfmetaproject LANGUAGES CXX)

#Automoc and RCC ON. Needed in QT projects
#set(CMAKE_AUTOMOC ON)
#set(CMAKE_AUTORCC ON)
#C++ 11 Flag
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


set(SUBDIRS 
 utils/helpers
 transport/vf-tcp
 transport/xiqnet
 utils/vf-crypto-bridge
 processing/vf-event  
 processing/vf-component
 storage/vf-storage-hash
 transport/vf-net2
 transport/vf-protobuf
 api/vf-qml
 processing/vf-script
 processing/vf-logger
 utils/vf-database-recorder
 utils/vf-database-replay
 utils/debugger
 utils/vf-unittest2
)

list(APPEND test 
"VfEvent"
"VfComponent"
"VfLogger"
"VfScript"
"Xinet"
"VfNet2"
"VfTcp"
"VfStorageHash"
"VfQml"
"VfHelpers"
"VfDebugger"
"VfUnittest2"
"VfRecorder"
"VfReplay"
"VfProtobuf"
"VfCryptoBridge"
)



macro(find_package)	
    if(NOT ${ARGV0} IN_LIST test)
       _find_package(${ARGV})
else()
	add_library("VeinMeta::${ARGV0}" ALIAS ${ARGV0})
    endif()
endmacro()

foreach(TMP_DIR ${SUBDIRS}) 
include_directories(${CMAKE_SOURCE_DIR}/${TMP_DIR})
add_subdirectory(${TMP_DIR})
endforeach()


