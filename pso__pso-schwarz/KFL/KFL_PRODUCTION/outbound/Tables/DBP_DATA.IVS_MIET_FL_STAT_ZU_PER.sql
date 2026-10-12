CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ivs_miet_fl_stat_zu_per (
mietvertrag_id STRING(20) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
flaeche_id STRING(20) COLLATE 'und:ci' NOT NULL,
flaeche_status_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);