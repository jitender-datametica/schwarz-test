CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_lagerprozess_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
lagernummer_id STRING(4) NOT NULL OPTIONS(description='Lagernummer'),
lagerprozess_id STRING(4) NOT NULL OPTIONS(description='Lagerungsprozess'),
richtung_id STRING(1) OPTIONS(description='Richtung (Lagerungsprozesstyp T333A)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Lagerprozess');