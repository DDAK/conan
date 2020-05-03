#!/bin/bash -x

export CONAN_USER_HOME=${CONAN_USER_HOME:-/opt/bt/conan}
export SCRIPTS_DIR="$( cd "$( echo "${BASH_SOURCE[0]%/*}/" )"; pwd )"

BUILD_TYPE=${BUILD_TYPE:-Release}

while getopts ":c:b:p:" opt; do
  case ${opt} in
    b )
      BUILD_TYPE=$OPTARG
      ;;
    c )
      CHANNEL=$OPTARG
      ;;
    p )
      PROFILE=$OPTARG
      ;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
      ;;
    : )
      echo "Invalid option: $OPTARG requires an argument" 1>&2
      ;;
  esac
done
shift $((OPTIND -1))


export CONAN_USER_HOME=${CONAN_USER_HOME:-/opt/bt/conan}
export SCRIPTS_DIR="$( cd "$( echo "${BASH_SOURCE[0]%/*}/" )"; pwd )"

conan create --test-folder="None"  --build grpc . grpc/1.18.0@bottomline/stable --settings build_type=${BUILD_TYPE}
