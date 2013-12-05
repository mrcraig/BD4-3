#!/bin/sh

HADOOP_TOPDIR=$( dirname $( readlink -f "$0" ) )
export HADOOP_HOME="${HADOOP_TOPDIR}"
export HIVE_HOME="${HADOOP_TOPDIR}"
export PIG_HOME="${HADOOP_TOPDIR}"
export HADOOP_CONF_DIR="${HADOOP_HOME}/conf"
export HIVE_CONF_DIR="${HADOOP_HOME}/conf"
export PATH="${PATH}:${HADOOP_HOME}/bin"
if [ -d /usr/lib/jvm/java-1.6.0/ ]; then
	export JAVA_HOME=/usr/lib/jvm/java-1.6.0
fi
if [ -z ${JAVA_HOME} ]; then
	echo "Remember to set JAVA_HOME to point to a JDK 1.6 installation"
	echo "E.g., export JAVA_HOME=/usr/lib/jvm/java-1.6.0"
fi

exec bash