CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_lagerprozess_extern_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
lagerprozess_extern_id STRING(4) NOT NULL OPTIONS(description='Externer Lagerungsprozessschritt'),
lagerprozess_intern_id STRING(4) OPTIONS(description='Interner Lagerungsprozessschritt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Extern Lagerprozess');