#!/bin/sh

cd ${SQL_INIT}/create && \
	echo "creazione database..." && \
	psql < Create_DB_XXXese.sql && \

	echo "creazione struttura..." && \
	psql -L ${SQL_INIT}/postgres.log -d sbnwebDB < sbnwebDbXXX_Completo.sql && \

	cd ${SQL_INIT}/init && \
	echo "creazione stop list..." && \
	psql -L ${SQL_INIT}/postgres.log -d sbnwebDB < 00_sbnwebDBinsert_ts_stop_list.sql && \

	echo "creazione lista attività..." && \
	psql -L ${SQL_INIT}/postgres.log -d sbnwebDB < 01_sbnwebDBinsert_tbf_attivita_sbnmarc-tbf_attivita.sql && \

	echo "creazione tabella codici..." && \
	psql -L ${SQL_INIT}/postgres.log -d sbnwebDB < 02_sbnwebDBinsert_tb_codici.sql && \
	
	echo "creazione tabella batch e default..." && \
	psql -L ${SQL_INIT}/postgres.log -d sbnwebDB < 03_sbnwebDBinsert_X_Batch_e_Default.sql && \
	
	echo "creazione tabella statistiche..." && \
	psql -L ${SQL_INIT}/postgres.log -d sbnwebDB < 03bis-sbnwebDBinsert_tabelle_statistiche.sql && \
	
	echo "creazione tabella parametri sbnmarc..." && \
	psql -L ${SQL_INIT}/postgres.log -d sbnwebDB < 04_sbnwebDBinsert_tbf_parametro.sql && \
	
	echo "definizione profilo Polo..." && \
	psql -L ${SQL_INIT}/postgres.log -d sbnwebDB < 05_Definisci_Polo.sql && \
	
	echo "abilitazione utente root..." && \
	psql -L ${SQL_INIT}/postgres.log -d sbnwebDB < 06_sbnwebDBinsert_AbilitaPolo_UtenzaRoot.sql

