CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.regio_polygon_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
regio_stufe_id BIGNUMERIC(38,0) NOT NULL,
regio_polygon_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
regio_polygon_bez STRING(50) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);