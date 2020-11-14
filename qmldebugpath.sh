#!/bin/bash 

SCRIPTPATH=""
help=0
executionPath=""
outputPath=""

# help 
help(){
    echo ./qmldebugpath.sh 
    echo    "-h show this help"
    echo    "-e set the executionPath (not needed usually)"
    echo    "-o set outputpath path: <outputpath>/qml/<pkg>/qmldir"

    echo "Attention: This script will only adapt qml file pathes started with qrc: in qmldir"
}



adaptFile(){

    copy=$1
    orig=$2

    # find all files in qmldir file
    readarray -d '' array < <(grep -o " qrc:.*qml" $copy"qmldir")
    
    # iterate files
    for t in ${array[@]}; do
        tmp=${t##*/} 
        # find file location
        path=$(find $orig -name $tmp)
        if [ "$path" != "" ]; then
                #echo $path
            # get realtive path between new qmldir file and qml file
            prefix=$(realpath --relative-to=$copy"qmldir" $path)
                #echo "found "$path
                #echo "replace "$t 
                #echo "with" $prefix
                #echo "in " $copy"qmldir"
            #replace file path
            sed -i "s+$t+$prefix+g" $copy"qmldir"
        fi

    done 

}


main(){

    # set work path (no files will be generated)
    if [ "$executionPath" == "" ]; then
        # Absolute path to this script. /home/user/bin/foo.sh
        SCRIPT=$(readlink -f $0)
        # Absolute path this script is in. /home/user/bin
        SCRIPTPATH=`dirname $SCRIPT`
    else
        SCRIPTPATH=realpath $executionPath
    fi


    # set outputpath (default is workpath/qml)
    if [ "$outputPath" == "" ]; then
        outputPath=$SCRIPTPATH/qml
    else
        outputPath=realpath $outputPath
        outputPath=$outputPath"qml"
    fi


    #echo $SCRIPTPATH
    rm -rf qml
    # find all qmldir files realtiv to workpath
    readarray -d '' array < <(find "$PWD" -name "qmldir" -print0)
    # create output folder
    mkdir $outputPath
    # iterate qmldir files
    for t in ${array[@]}; do
        #get path
        tmp1=${t%/qmldir*}
        tmp2=${tmp1##*/} 
        # get pkg name
        folder="$tmp2/"
        #create pkg folder
        mkdir $outputPath/$folder/
        # copy qmldir file
        cp $t $outputPath/$folder
        # adapt qmldir file
        adaptFile $outputPath/$folder $tmp1
    done
}


while getopts "he:o:" OPTION; do
    case $OPTION in
    h)
        help
        exit 0
        ;;
    e)
        executionPath=$OPTARG
        ;;
    o)
        outputPath=$OPTARG
        ;;
    *)
        echo "Incorrect options provided"
        exit 1
        ;;
    esac
done

main
exit 0
