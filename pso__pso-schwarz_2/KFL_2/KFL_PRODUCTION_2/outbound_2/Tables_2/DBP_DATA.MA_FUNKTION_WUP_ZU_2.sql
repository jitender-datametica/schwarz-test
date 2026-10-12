CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ma_funktion_wup_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Betriebsnummer'),
ma_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH ID des Mitarbeiters'),
ma_funktion_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='eindeutige ID der Mitarbeiter-Funktion'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description='VIS - alternative Hierarchiezuordnungen für alles, was in die normale Hierarchie nicht passt. Aus zrsvsother');