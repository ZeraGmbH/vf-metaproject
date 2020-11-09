# This calls the qmldebugpath.sh script with output directory ${CMAKE_INSTALL_PREFIX} if qmldebug is ON
# That means qmldir files will be generated like this ${CMAKE_INSTALL_PREFIX}/qml/<pkg>/qmldir
# Please note. The execution directory is the directory of this file. It will search for all
# qmldir files in subfolders and generate












option(ZERA_qmldebug "create qml debug folder" ON)

if(ZERA_qmldebug)
        execute_process(COMMAND ./qmldebugpath.sh -o ${CMAKE_INSTALL_PREFIX}/
			WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
	)
endif()
