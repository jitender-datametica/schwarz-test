CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.trg_artbew_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
datzeit_aenderung TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel eines Eintrags nach Triggering'),
dat DATE NOT NULL OPTIONS(description='Datum, Format YYYY-MM_1-DD'),
trg_action BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Trigger Aktion_1 (1=Insert; 2=Update; 3= Delete)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description='AIS - Zieltabelle von Trigger trg_artbew_1 zur Replikation von Daten nach Hadoop - Bei Änderungen auf die Tabelle artbew_1 wir die entsprchend geänderte Partition hier mit einem Zeitstempel gespeichert.');