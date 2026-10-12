CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_best_entw_typ_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
best_entw_typ_id STRING(1) COLLATE 'und:ci' NOT NULL,
nachbelastung_fg BIGNUMERIC(38,0) NOT NULL,
preis_pruefen_fg BIGNUMERIC(38,0) NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);