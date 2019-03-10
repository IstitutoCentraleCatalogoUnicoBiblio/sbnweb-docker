#!/bin/sh

#eliminazione librerie obsolete
cd ${SERVER_DIR}/lib
rm -f commons-codec.jar
rm -f commons-collections.jar
rm -f commons-httpclient.jar
rm -f hibernate3.jar
rm -f quartz.jar

#eliminazione conf. obsolete
cd ${SERVER_DIR}/deploy/jms
rm -f hsqldb-jdbc2-service.xml
