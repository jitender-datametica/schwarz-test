CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.replikation_hadoop_dat_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_2-TT'),
zieltabelle_bez STRING(50) NOT NULL OPTIONS(description='Zieltabelle des Replikationsprozess'),
replikation_bez STRING(255) OPTIONS(description='Beschreibung des Replikationsprozesses'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='HDP - Lookup-Tabelle für die Hadoop-Replikation');