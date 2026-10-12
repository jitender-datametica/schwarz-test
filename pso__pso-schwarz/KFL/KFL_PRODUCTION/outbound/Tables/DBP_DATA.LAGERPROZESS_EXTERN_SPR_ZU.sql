CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lagerprozess_extern_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
lagerprozess_extern_id STRING(4) NOT NULL OPTIONS(description='Externer Lagerungsprozessschritt'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
lagerprozess_extern_bez STRING(40) OPTIONS(description='Bezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Externer Lagerprozess - Beschreibung');