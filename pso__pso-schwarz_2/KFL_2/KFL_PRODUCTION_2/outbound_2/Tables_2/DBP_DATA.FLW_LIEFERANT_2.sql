CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_lieferant_2 (
flw_lief_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
lief_name_1 STRING(40) COLLATE 'und:ci' NOT NULL,
lief_name_2 STRING(40) COLLATE 'und:ci' NOT NULL,
gp_ort STRING(40) COLLATE 'und:ci' NOT NULL,
gp_plz STRING(10) COLLATE 'und:ci' NOT NULL,
flw_lief_nr STRING(10) COLLATE 'und:ci' NOT NULL,
flw_lief_id_cz BIGNUMERIC(38,0) NOT NULL,
lief_betreuer_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
werk_id_flw BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
mandant_id_werk BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);