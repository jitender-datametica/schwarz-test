CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_lagerprozesstyp (
lagerprozesstyp_id STRING(1) NOT NULL OPTIONS(description='Lagerprozesstyp'),
aktivitaet_fg STRING(1) OPTIONS(description='Aktivität'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Lagerprozesstyp');