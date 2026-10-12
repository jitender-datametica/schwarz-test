CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_qual_instand_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
qual_meldung_id INTEGER NOT NULL,
ausfall_fg BIGNUMERIC(38,0) NOT NULL,
ausfallzeit_sekunden BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);