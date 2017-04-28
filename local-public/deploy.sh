#!/bin/bash
set -e
unamestr=$(uname)
SCRIPTFILE="undefined"
# docker machine name in non-linux dev environments
DOCKER_MACHINE="default"

# Use NET_IF to override network interface, example: NET_IF=enp0s3 ./deploy.sh all
if [ "$NET_IF" = "" ]; then
  NET_IF="eth0"
fi

# check os, os x users install coreutils: brew install coreutils
if [ $unamestr == "Linux" ]; then
  SCRIPTFILE=$(readlink -f "$0")
elif [ $unamestr == "Darwin" ]; then
  SCRIPTFILE=$(greadlink -f "$0")
fi
SCRIPTPATH=$(dirname "$SCRIPTFILE")

# check usage
if [ -z "$1" ]; then
  echo "Usage: $0 <app-name> [dontpull]"
  exit 0
fi
APP=$1

# read local deploy properties
PROPERTIES_FILE=~/kapa/deploy-local.properties
if [ ! -f $PROPERTIES_FILE ]; then
  echo "Properties file $PROPERTIES_FILE missing"
  exit 0
fi

source $PROPERTIES_FILE
ANSIBLE_DIR=$SCRIPTPATH/../deploy
DEPLOY_DIR=$deploy_dir
LOG_DIR=$log_dir

#Check dontpull
dontpull=""
if [ ! -z "$2" ] && [ "$2" == "dontpull" ];
then
   dontpull="-e do_not_pull_image="
fi

cd $ANSIBLE_DIR

#External router

if [ $APP = "external-router" -o $APP = "all" -o $APP = "ifconfig" ]; then
  EXT_IP=`grep 'ext_router_ports' $SCRIPTPATH/configs/infra.yml|sed -e 's/.* \([0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\).*/\1/'`
  if [ $unamestr == "Linux" ]
  then
    if ! ping -W 1 -c 1 ${EXT_IP} > /dev/null
    then
      echo ${EXT_IP} missing, running sudo ifconfig ${NET_IF}:0 ${EXT_IP}
      sudo ifconfig ${NET_IF}:0 ${EXT_IP}
    fi
  elif [ $unamestr == "Darwin" ]
  then
    if ! docker-machine ssh default "ping -W 1 -c 1 ${EXT_IP} > /dev/null"
    then
      echo ${EXT_IP} missing in docker machine, running sudo ifconfig ${NET_IF}:0 ${EXT_IP} on docker machine
      docker-machine ssh default sudo ifconfig ${NET_IF}:0 ${EXT_IP}
    fi
  fi
fi

#hst-router

if [ $APP = "hst-router" -o $APP = "all" -o $APP = "ifconfig" ]; then
  HST_IP=`grep 'hst_router_ports' $SCRIPTPATH/configs/infra.yml|sed -e 's/.* \([0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\).*/\1/'`
  if ! ping -W 1 -c 1 ${HST_IP} > /dev/null
  then
    echo ${HST_IP} missing, running sudo ifconfig ${NET_IF}:1 ${HST_IP}
    sudo ifconfig ${NET_IF}:1 ${HST_IP}
  fi
fi

#Elisa mock IP for local SSH pipe

if [ $APP = "mobile-idp" -o $APP = "all" -o $APP = "ifconfig" ]; then
  ELISA_IP="192.168.0.10"
  if ! ping -W 1 -c 1 ${ELISA_IP} > /dev/null
  then
    echo ${ELISA_IP} missing, running sudo ifconfig ${NET_IF}:2 ${ELISA_IP}
    sudo ifconfig ${NET_IF}:2 ${ELISA_IP}
  fi
fi

#test-service

if [ $APP = "test-service" -o $APP = "all" -o $APP = "ifconfig" ]; then
  TESTSERVICE_IP="192.168.0.3"
  if ! ping -W 1 -c 1 ${TESTSERVICE_IP} > /dev/null
  then
    echo ${TESTSERVICE_IP} missing, running sudo ifconfig ${NET_IF}:3 ${TESTSERVICE_IP}
    sudo ifconfig ${NET_IF}:3 ${TESTSERVICE_IP}
   fi
 fi

#vartti

if [ $APP = "vartti" -o $APP = "all" -o $APP = "ifconfig" ]; then
  VARTTI_IP="192.168.0.4"
  if ! ping -W 1 -c 1 ${VARTTI_IP} > /dev/null
  then
    echo ${VARTTI_IP} missing, running sudo ifconfig ${NET_IF}:4 ${VARTTI_IP}
    sudo ifconfig ${NET_IF}:4 ${VARTTI_IP}
   fi
 fi

ansible-playbook -v -i $SCRIPTPATH/ansible_hosts e-identification-deploy.yml  -e deploy_root=$DEPLOY_DIR -e conf_root=$SCRIPTPATH -e do_not_pull_image= --tags="$APP"
ansible-playbook -v -i $SCRIPTPATH/ansible_hosts e-identification-metadata-update.yml -e deploy_root=$DEPLOY_DIR -e conf_root=$SCRIPTPATH -e confdir=$SCRIPTPATH/local_configs/metadata --tags="$APP"

