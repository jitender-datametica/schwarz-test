CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.warenbewegungstyp_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
warenbewegungstyp_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Warenbewegungstyp'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprachschlüssel'),
warenbewegungstyp_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Bez. Warenbewegungstyp'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Beschreibung Warenbewegungstyp');