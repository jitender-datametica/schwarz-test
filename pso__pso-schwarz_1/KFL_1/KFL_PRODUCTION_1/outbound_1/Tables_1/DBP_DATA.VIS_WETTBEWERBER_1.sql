CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vis_wettbewerber_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
wb_rang BIGNUMERIC(38,0) NOT NULL,
wb_name STRING(100) COLLATE 'und:ci',
wb_dat_von DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);