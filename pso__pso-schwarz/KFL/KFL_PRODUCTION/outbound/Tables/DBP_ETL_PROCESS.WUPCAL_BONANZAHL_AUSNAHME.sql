CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.wupcal_bonanzahl_ausnahme (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer des Warenumschlagsplatzes'),
kasse_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer der Kasse'),
dat_von DATE OPTIONS(description='Datum, ab dem die Ausnahme gelten soll'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description='VIS Ladehilfstabelle - Bons dieser Kassen bei bonanzahl nicht berücksichtigen. Wird per Makro versorgt');