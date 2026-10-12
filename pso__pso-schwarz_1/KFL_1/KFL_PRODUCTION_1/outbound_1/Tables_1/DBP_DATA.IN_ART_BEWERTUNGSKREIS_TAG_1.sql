CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_art_bewertungskreis_tag_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
in_art_id BIGNUMERIC(38,0) NOT NULL,
bewertungskreis_id STRING(4) NOT NULL,
dat DATE NOT NULL,
wrg_id STRING(3) DEFAULT '   ' NOT NULL,
menge_bestand_bme NUMERIC(18,3) DEFAULT 0,
betrag_preis_bestand NUMERIC(18,2) DEFAULT 0,
td_update TIMESTAMP,
td_insert TIMESTAMP
) CLUSTER BY mandant_id;