FROM postgres:9.6

LABEL MANTAINER=ICCU

#locale a IT
RUN localedef -i it_IT -c -f UTF-8 -A /usr/share/locale/locale.alias it_IT.UTF-8
ENV LANG it_IT.UTF-8

ENV SQL_INIT /sql

RUN addgroup --gid 1000 hostuser && usermod -a -G hostuser postgres

#copia script init DB
RUN mkdir -p ${SQL_INIT}
COPY sql ${SQL_INIT}
RUN chown -R postgres:postgres ${SQL_INIT}

#USER postgres

COPY init_db.sh /docker-entrypoint-initdb.d
