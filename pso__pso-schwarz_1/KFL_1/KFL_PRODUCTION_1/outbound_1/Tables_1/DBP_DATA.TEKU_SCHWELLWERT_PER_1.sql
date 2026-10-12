CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.teku_schwellwert_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
teku_berichts_objekt_id STRING(20) COLLATE 'und:ci' NOT NULL,
teku_hierarchie_objekt_id STRING(20) COLLATE 'und:ci' NOT NULL,
teku_spalte_bez STRING(255) COLLATE 'und:ci' NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
sw_gruen_bis NUMERIC(9,2) NOT NULL,
sw_rot_ab NUMERIC(9,2) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);