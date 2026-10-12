CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.regio_polygon_art_gp_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
regio_stufe_id BIGNUMERIC(38,0) NOT NULL,
regio_polygon_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
gp_id BIGNUMERIC(38,0) NOT NULL,
genehmigt_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);