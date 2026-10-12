CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_warenbewegungstyp_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
warenbewegungstyp_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Warenbewegungstyp'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Lookup Warenbewegungstyp');