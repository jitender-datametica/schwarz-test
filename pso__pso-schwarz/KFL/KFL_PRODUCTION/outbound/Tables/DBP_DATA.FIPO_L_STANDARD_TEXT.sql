CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_l_standard_text (
fipo_standard_text_id BIGNUMERIC(38,0) NOT NULL,
fipo_pruefpunkt_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
fipo_standard_text_nr BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);