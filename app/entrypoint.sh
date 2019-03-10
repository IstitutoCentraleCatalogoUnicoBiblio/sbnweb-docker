#!/bin/bash

echo "user: $USER:$GROUP --> cmd: $@"

#fix permessi cartelle
set -ex && \
    chown -R $USER:$GROUP ${SERVER_DIR}/log && \
    chown -R $USER:$GROUP ${SERVER_DIR}/data && \
    chown -R $USER:$GROUP ${SERVER_DIR}/work && \
    chown -R $USER:$GROUP ${SERVER_DIR}/tmp && \
    chown -R $USER:$GROUP ${JUSER_HOME}/sbn/download && \
    chown -R $USER:$GROUP ${EXPORT_HOME}/exportUnimarc/db_export && \
    chown -R $USER:$GROUP ${EXPORT_HOME}/exportUnimarc/dp/unimarc && \
	chown -R $USER:$GROUP ${EXPORT_HOME}/exportUnimarc/dp/input && \
    chmod 777 ${EXPORT_HOME}/exportUnimarc/dp/unimarc

exec gosu "$USER" "$@"
