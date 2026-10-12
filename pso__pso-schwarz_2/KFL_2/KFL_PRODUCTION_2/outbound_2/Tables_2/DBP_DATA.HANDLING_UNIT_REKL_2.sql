CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.handling_unit_rekl_2 (
handling_unit_id INTEGER NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
handling_unit_pos_id BIGNUMERIC(38,0) NOT NULL,
dat_buch DATE NOT NULL,
dat_erfasst DATE NOT NULL,
menge_bme NUMERIC(18,3) NOT NULL,
tour_id INTEGER NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
vz_wup_id BIGNUMERIC(38,0) NOT NULL,
lis_rekl_grund_id BIGNUMERIC(38,0) NOT NULL,
lis_rekl_status_id STRING(10) COLLATE 'und:ci' NOT NULL,
versandstelle_id STRING(4) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);