# SBNWeb-docker

Installazione dell'applicativo LMS **SBNWeb Open** in ambiente Docker.

## Licenza

[![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)

## Requisiti di installazione

|Requisito| Versione |
|---|---|
|[Docker](https://docs.docker.com/install)| >= 18.03|
|[Docker Compose](https://docs.docker.com/compose/install)| >= 1.22 |
|[Linux](https://www.kernel.org)| >= kernel 3.10 64bit |

## Installazione

### Clonare il repository

```git clone --recursive https://github.com/IstitutoCentraleCatalogoUnicoBiblio/sbnweb-docker.git```

### Personalizzazione del DB

Portarsi nella cartella:

    sbnweb-docker/db/sql/init

e modificare lo script SQL **```05_Definisci_Polo.sql```** personalizzando i campi per il polo da installare.

|Campo| Descrizione |
|---|---|
|cd_polo|Codice del polo|
|url_indice|URL per il collegamento a Indice SBN|
|username|Nome utente|
|password|Password per Indice SBN|
|denominazione|Descrizione del Polo|
|email|Indirizzo mail per il gestore|

## Build della piattaforma

Portarsi nella cartella:

    sbnweb-docker

ed eseguire il comando:

```docker-compose up --build --no-start```

## Avvio applicazione

Eseguire il comando:

```docker-compose up -d```

L'applicazione sarà raggiungibile all'indirizzo:

    http://localhost:8080/sbn

## Stop applicazione

Eseguire il comando:

```docker-compose stop```

## File di configurazione

Nella cartella:

    sbnweb-docker/conf

sono presenti i file di configurazione modificabili dall'utente:

|File| Descrizione |
|---|---|
|**sbnweb.conf**| configurazione di SBNWeb|
|**SbnWebPostgres-ds.xml**| configurazione per l'accesso al DB Postgres|
|**downloadSBW.txt**| configurazione per l'accesso al DB della procedura UNIMARC|
|**offlineExportUnimarc.linux.cfg**| configurazione della procedura UNIMARC|

## Cartelle condivise con la macchina host

|Cartella| Descrizione |
|---|---|
|**runtime-data/db_data**|database di SBNWeb|
|**runtime-data/app_data/log**|log di JBoss AS|
|**runtime-data/app_data/download**|output elaborazioni differite|
|**runtime-data/app_data/export/unimarc**|output estrazioni UNIMARC|
