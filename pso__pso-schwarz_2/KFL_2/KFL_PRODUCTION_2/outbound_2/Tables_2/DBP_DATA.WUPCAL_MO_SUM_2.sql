CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wupcal_mo_sum_2 (
wup_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
gjmo BIGNUMERIC(38,0),
anzahl_oeff_tage BIGNUMERIC(38,0),
offen BIGNUMERIC(38,0),
bonanzahl BIGNUMERIC(38,0),
anzahl_lief_tage BIGNUMERIC(38,0),
bonanzahl_gastro BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);