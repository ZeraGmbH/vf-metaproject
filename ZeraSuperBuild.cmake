
# This extension simplifies cmake superprojects
# 
# 1. create a git repo 
# 2. add submodules to repo
# 3. create cmake SuperProject file and include this file
# 4. use Macro as follows
#
# set(name projectFolder)
# set(path Path/to/)
# set(deps other external projects)
# add_sub_project_deps(${name} ${path} "deps")
#
# Please Note that the order is important. Because cmake can not resolve the deps otherwise




include(${CMAKE_ROOT}/Modules/ExternalProject.cmake)

option(firstBuild "set to on for the first project build/set off when you start working with the project" ON)

if(firstBuild)
#Silent subdirs
#force all find_package calls to be Quiet
    macro(find_package)
        string(REGEX REPLACE "REQUIRED" "QUIET" OUT "${ARGV}")
        _find_package(${OUT})
    endmacro()

    macro(pkg_check_modules)

    endmacro()


    macro(target_link_libraries)

    endmacro()

endif()



macro(add_sub_project_deps name path _depends)
    #The internal names are extended with _ext to prevent conflicts with the target names used in the subdirectories.
    foreach(TMP_DEP ${${_depends}})
         list(APPEND deps_ext ${TMP_DEP}_ext)
    endforeach()

    if(NOT firstBuild)
        add_subdirectory(${CMAKE_SOURCE_DIR}/${path}/${name})
    else()
        # We want to see the project in QT creator. Therefore we have to add the subdirectory
        # But we do not want to use it. EXCLUDE_FROM_ALL suppresses build in this directory

        #Lets build the project as external project now

        ExternalProject_Add(${name}_ext
                SOURCE_DIR ${CMAKE_SOURCE_DIR}/${path}/${name}
                BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}/${path}/${name}
                CMAKE_CACHE_ARGS 
                    -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_INSTALL_PREFIX}
                    -DCMAKE_PREFIX_PATH:PATH=${CMAKE_PREFIX_PATH}
                    -DCMAKE_INSTALL_SYSCONFDIR:PATH=${CMAKE_INSTALL_SYSCONFDIR}
                    -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
                    -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
                DEPENDS
                    ${deps_ext}
       )
    endif()
endmacro()
