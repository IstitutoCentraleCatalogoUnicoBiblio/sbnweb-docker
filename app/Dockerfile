FROM maven:3.6-jdk-8 AS SBNWEB_BUILDER

LABEL MANTAINER=ICCU

#copia codice sorgente
COPY sbnweb /sbnweb-src

#compilazione modulo SBNWeb
WORKDIR /sbnweb-src/SBNWeb
RUN mv local-settings.properties.template local-settings.properties && \
	mvn clean && \
	mvn install

#compilazione modulo SBNMarc
WORKDIR /sbnweb-src/sbnmarc
RUN mv local-settings.properties.template local-settings.properties && \
	mvn clean && \
	mvn install

	
FROM ubuntu:16.04 AS UNIMARC_BUILDER

#aggiornamento sistema linux
RUN set -e; apt-get update
RUN set -e; apt-get install -y build-essential

RUN mkdir -p /home/export/workspace/cdt/offlineExportUnimarc

#copia codice sorgente UNIMARC
COPY sbnweb/exportUnimarc/offlineExportUnimarc /home/export/workspace/cdt/offlineExportUnimarc

WORKDIR /home/export/workspace/cdt/offlineExportUnimarc/Debug

#compilazione modulo UNIMARC
RUN set -e; make


FROM openjdk:8-jdk-stretch

ENV JBOSS_FILE jboss-4.2.3.GA
ENV JBOSS_URL https://sourceforge.net/projects/jboss/files/JBoss/JBoss-4.2.3.GA/jboss-4.2.3.GA-jdk6.zip/download
ENV DEST_DIR /usr/local
ENV SERVER_DIR ${DEST_DIR}/${JBOSS_FILE}/server/default
ENV JUSER_HOME /home/jboss
ENV EXPORT_HOME /export

#creazione utente jboss
RUN useradd -m jboss -d ${JUSER_HOME}

#creazione utente export
RUN useradd -m export -d ${EXPORT_HOME} && \
	usermod -a -G export jboss

#aggiornamento sistema linux
RUN apt-get update && \
	apt-get install -y wget zip unzip less gosu

WORKDIR /tmp

#download JBoss AS runtime
RUN set -e; \
    wget -q -O ${JBOSS_FILE}.zip ${JBOSS_URL}

RUN	cd ${DEST_DIR} && \
	unzip /tmp/${JBOSS_FILE}.zip && \
    rm -rf ${DEST_DIR}/${JBOSS_FILE}/server/all && \
    rm -rf ${DEST_DIR}/${JBOSS_FILE}/server/minimal && \
	rm -f /tmp/${JBOSS_FILE}.zip

#personalizzazione configurazione JBoss
COPY data/jboss ${DEST_DIR}/${JBOSS_FILE}
COPY data/home ${JUSER_HOME}

#copia ambiente UNIMARC
COPY sbnweb/exportUnimarc/export ${EXPORT_HOME}

#personalizzazione configurazione UNIMARC
COPY data/export ${EXPORT_HOME}

#copia applicazioni SBNWeb, SBNMarc e UNIMARC
COPY --from=SBNWEB_BUILDER /sbnweb-src/SBNWeb/build/sbn.ear ${SERVER_DIR}/deploy
COPY --from=SBNWEB_BUILDER /sbnweb-src/sbnmarc/target/sbnMarc.ear ${SERVER_DIR}/deploy
COPY --from=UNIMARC_BUILDER /home/export/workspace/cdt/offlineExportUnimarc/Debug/offlineExportUnimarc ${EXPORT_HOME}/exportUnimarc/dp

RUN apt-get install -y lib32stdc++6 && \
	apt-get clean

#fix permessi
RUN	chown -R jboss:jboss ${DEST_DIR}/${JBOSS_FILE}
RUN	chown -R jboss:jboss ${JUSER_HOME}
RUN chown -R export:export ${EXPORT_HOME} && \
	chmod -R g+w ${EXPORT_HOME} && \
	cd ${EXPORT_HOME}/exportUnimarc/dp && \
	chmod -R 775 *.sh && \
	chmod -R 775 export/*.sh && \
	chmod 775 offlineExportUnimarc
RUN chmod 775 ${JUSER_HOME}/fix-libs.sh && ${JUSER_HOME}/fix-libs.sh

EXPOSE 8080

VOLUME ${SERVER_DIR}/log
VOLUME ${SERVER_DIR}/data
VOLUME ${SERVER_DIR}/work
VOLUME ${SERVER_DIR}/tmp
VOLUME ${JUSER_HOME}/sbn/download

VOLUME ${EXPORT_HOME}/exportUnimarc/db_export
VOLUME ${EXPORT_HOME}/exportUnimarc/dp/input
VOLUME ${EXPORT_HOME}/exportUnimarc/dp/unimarc

COPY entrypoint.sh /usr/local/bin
RUN chmod 755 /usr/local/bin/entrypoint.sh

ENV USER jboss
ENV GROUP jboss
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

WORKDIR ${DEST_DIR}/${JBOSS_FILE}/bin

CMD ["./run.sh", "-b", "0.0.0.0"]
