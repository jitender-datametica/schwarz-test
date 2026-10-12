CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vis_zaehl_auftrag_2 (
art_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
dat_auftrag DATE NOT NULL,
zaehl_grund_id STRING(3) COLLATE 'und:ci' NOT NULL,
bezugsweg_id BIGNUMERIC(38,0) NOT NULL,
zaehl_sort_id STRING(20) COLLATE 'und:ci' NOT NULL,
dat_zaehl DATE,
zeit_zaehl TIME,
gesendet_fg BIGNUMERIC(38,0) OPTIONS(description='Gesendet-Flag'),
td_insert TIMESTAMP,
td_update TIMESTAMP
);