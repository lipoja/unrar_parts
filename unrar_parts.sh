#!/bin/bash



# First test if unrar is installed
tmp=`which unrar`
if [ $? -ne 0 ]; then
    echo "ERROR: unrar is not installed or is not in PATH"
    exit 1
fi

# GLOBALS #
INSTALL_PATH="/usr/bin/unrar_parts"
PWDir=`pwd`

if [ "$#" -eq 0 ]; then
    DIRECTORY=`pwd`"/"
fi

if [ "$(whoami)" != "root" ]; then
    SUDO="sudo"
else
    SUDO=""
fi


trap ctrl_c INT

# catching sigint
function ctrl_c() {
        echo "** Script stopped by user CTRL-C"
        cd "$PWDir"
        exit 1
}

function myinstall () {
    $SUDO echo -ne "Installing unrar_parts: ..."
    $SUDO cp -f "$0" $INSTALL_PATH
    echo "DONE"
    exit 0
}

function myuninstall () {
    $SUDO echo -ne "Removing unrar_parts from system: ..."
    $SUDO rm -rf $INSTALL_PATH
    echo "DONE"
    exit 0
}

show_help () {
    echo "Usage: unrar_parts [options] [direcotry]"
    echo "------------------------------------------------------------------"
    echo -e "directory\t Path to directory with rar files splited to parts"
    echo -e "\t\t If not set current directory will be used (pwd)"
    echo -e "--install\t Copy script to '$INSTALL_PATH'"
    echo -e "--uninstall\t Remove script '$INSTALL_PATH'"
    echo -e "--help, -h\t Show this text"

    exit 0
}

while [ "$#" != "0" ]; do
    if [ "$1" == "--install" ]; then
        myinstall
    elif [ "$1" == "--uninstall" ]; then
        myuninstall
    elif [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
        show_help
    else
        DIRECTORY="$1"
   fi
    shift
done


if [ -d "$DIRECTORY" ]; then
    cd "$DIRECTORY"
    shopt -s nullglob
    PROCESSED_FILES=0
    for file in `ls | grep "part\([0]*\)1"`
    do
        PROCESSED_FILES=$[PROCESSED_FILES+1]
        echo "Unpacking file $file"
        unrar -o+ e "$file"
        ret=$?
        if [ $ret -eq 0 ]; then
             for rmf in `echo $file | sed 's/part\([0]*\)1/part\*/g'`
             do
                echo "Deleting file: $rmf"
                rm -f "$rmf"
             done
        else
            echo "ERROR: Could not extract file: $file"
        fi
    done

    if [ $PROCESSED_FILES -eq 0 ]; then
        echo "Nothing to process"
    else
        echo "Processed $PROCESSED_FILES groups of rar files"
    fi
else
    echo "ERROR: Directory does not exist [$DIRECTORY]"
    cd "$PWDir"
    exit 1
fi

cd "$PWDir"