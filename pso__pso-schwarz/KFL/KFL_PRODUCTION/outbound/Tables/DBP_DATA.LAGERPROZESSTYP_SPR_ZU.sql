CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lagerprozesstyp_spr_zu (
lagerprozesstyp_id STRING(1) NOT NULL OPTIONS(description='Lagerprozesstyp'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
lagerprozesstyp_bez STRING(40) OPTIONS(description='Lagerprozesstyp Bezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Lagerprozesstyp Bezeichnung');