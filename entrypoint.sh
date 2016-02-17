#!/bin/bash
# Simple bash entrypoint. It will configure the docker at run, and then
# exec the init process.

debug=${ENTRYPOINT_DEBUG:-"no"}
function log(){
  if [ "$debug" == "yes" ]; then
    echo "entrypoint: ${@}"
  fi
}
if [ -x /etc/entrypoint/setup.d/ ]; then
  for file in /etc/entrypoint/setup.d/*; do
    if [ -x $file ]; then
      log "running $file" 
      $file
    fi
  done
fi

exec $@
