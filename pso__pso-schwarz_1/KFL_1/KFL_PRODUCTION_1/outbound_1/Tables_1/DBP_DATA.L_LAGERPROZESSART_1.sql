CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_lagerprozessart_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
lagernummer_id STRING(4) NOT NULL OPTIONS(description='Lagernummer'),
lagerprozessart_id STRING(4) NOT NULL OPTIONS(description='Lagerprozessart'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Lagerprozessart');