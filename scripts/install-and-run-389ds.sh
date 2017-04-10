#!/bin/bash
set -e

export DIRSRV_HOSTNAME=${DIRSRV_HOSTNAME:-$(hostname --fqdn)}
export DIRSRV_ADMIN_USERNAME=${DIRSRV_ADMIN_USERNAME:-"admin"}
export DIRSRV_ADMIN_PASSWORD=${DIRSRV_ADMIN_PASSWORD:-${DIRSRV_MANAGER_PASSWORD:-"admin@123"}}
export DIRSRV_MANAGER_PASSWORD=${DIRSRV_MANAGER_PASSWORD:-${DIRSRV_ADMIN_PASSWORD:-"admin@123"}}
export DIRSRV_SUFFIX=${DIR_SUFFIX:-"dc=example,dc=com"}

BASEDIR="/etc/dirsrv/slapd-dir"
ROOT_DN="cn=Directory Manager"
RUN_DIR="/var/run/dirsrv"
LOG_DIR="/var/log/dirsrv/slapd-dir"
LOCK_DIR="/var/lock/dirsrv/slapd-dir"

#
# Setup
#
setup() {
  /bin/cp -rp /etc/dirsrv-tmpl/* /etc/dirsrv
  /sbin/setup-ds.pl -s -f /389ds-setup.inf --debug &&
  /bin/rm -f /389ds-setup.inf
}

#
# Load the example_com domain with sample users/groups
#
load_example_com() {
  #start and run ns-slapd
  ns-slapd -D $BASEDIR && sleep 5
  ldapadd -x -c -D"$ROOT_DN" -w${DIRSRV_MANAGER_PASSWORD} -f /tmp/users_and_groups.ldif
  pkill -f ns-slapd  && sleep 5
}


if [ ! -d ${LOCK_DIR} ]; then
   mkdir -p ${RUN_DIR} && chown -R nobody:nobody ${RUN_DIR}
   mkdir -p ${LOCK_DIR} && chown -R nobody:nobody ${LOCK_DIR}
fi

if [ ! -d "$BASEDIR" ]; then
   /usr/local/bin/confd -onetime -backend env
   setup
   load_example_com
fi

# Run the DIR Server
exec /usr/sbin/ns-slapd -D ${BASEDIR} -d 0
