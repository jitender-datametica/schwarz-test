CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_art_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
in_art_id BIGNUMERIC(38,0) NOT NULL,
in_art_nr STRING(20) NOT NULL,
basismenge_einh_id STRING(3) NOT NULL,
artikelart_id STRING(4) NOT NULL,
best_menge_einh_id STRING(3) NOT NULL,
art_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
in_wg_id STRING(10) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
einkaeufer_bis_int_id STRING(3),
einkaeufer_grp_id STRING(3) DEFAULT '   ' NOT NULL,
pos_typ_id STRING(4) DEFAULT '    ' NOT NULL,
status_kz STRING(2) DEFAULT '  ' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);