CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.handling_unit_beleg_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
quelle STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Quelltabelle SAP'),
log_guid STRING(32) NOT NULL OPTIONS(description='Warenbewegungslog HU'),
handling_unit_guid STRING(32) NOT NULL OPTIONS(description='Handling Unit_2 GUID'),
beleg_guid STRING(32) NOT NULL OPTIONS(description='Beleg-ID'),
belegtyp_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Belegtyp'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='HU-Beleg Referenz EWM');