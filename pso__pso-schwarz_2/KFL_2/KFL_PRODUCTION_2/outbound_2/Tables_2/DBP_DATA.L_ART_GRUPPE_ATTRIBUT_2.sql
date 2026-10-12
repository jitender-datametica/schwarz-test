CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_art_gruppe_attribut_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
art_gruppe_id STRING(5) COLLATE 'und:ci' NOT NULL,
art_attribut_id STRING(5) COLLATE 'und:ci' DEFAULT '     ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);