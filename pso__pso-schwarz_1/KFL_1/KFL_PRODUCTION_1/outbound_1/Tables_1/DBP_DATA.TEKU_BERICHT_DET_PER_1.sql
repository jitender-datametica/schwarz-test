CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.teku_bericht_det_per_1 (
teku_antwort_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
teku_antwort_note NUMERIC(9,2),
teku_antwort_bez STRING(1000) COLLATE 'und:ci',
teku_bericht_id BIGNUMERIC(38,0) NOT NULL,
teku_fragestellung_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);