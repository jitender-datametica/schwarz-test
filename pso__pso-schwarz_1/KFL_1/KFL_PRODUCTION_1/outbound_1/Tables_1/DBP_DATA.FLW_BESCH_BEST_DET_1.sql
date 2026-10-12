CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_besch_best_det_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
best_beleg_id INTEGER NOT NULL,
best_beleg_pos_id BIGNUMERIC(38,0) NOT NULL,
flw_art_id BIGNUMERIC(38,0),
menge_best_bme NUMERIC(18,3) NOT NULL,
best_menge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL,
best_preis_menge_einh_id STRING(3) COLLATE 'und:ci',
loesch_id STRING(1) COLLATE 'und:ci' NOT NULL,
werk_id BIGNUMERIC(38,0),
retourenpos_fg BIGNUMERIC(38,0) NOT NULL,
dupli_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
besch_pos_typ_id STRING(1) COLLATE 'und:ci' NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
nettopreis NUMERIC(18,4) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);