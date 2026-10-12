CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lgnum_vstel_sortiment_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
lagernummer_id STRING(4) NOT NULL OPTIONS(description='Lagernummer'),
versandstelle_id STRING(4) NOT NULL OPTIONS(description='versandstelle_id'),
lagersortiment_id STRING(1) NOT NULL OPTIONS(description='Lagersortiment ID'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Lagernummer / Versandstelle / Lagersortiment Zuordnung');