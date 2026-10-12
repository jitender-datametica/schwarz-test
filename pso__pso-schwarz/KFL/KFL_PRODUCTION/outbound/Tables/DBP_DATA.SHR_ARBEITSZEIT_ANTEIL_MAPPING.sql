CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.shr_arbeitszeit_anteil_mapping (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kjmo_bis BIGNUMERIC(38,0) NOT NULL,
anz_stunden_bis NUMERIC(9,2) NOT NULL,
kjmo_von BIGNUMERIC(38,0) DEFAULT 0,
anz_stunden_von NUMERIC(9,2) DEFAULT 0 NOT NULL,
arbeitszeit_anteil NUMERIC(9,2) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);