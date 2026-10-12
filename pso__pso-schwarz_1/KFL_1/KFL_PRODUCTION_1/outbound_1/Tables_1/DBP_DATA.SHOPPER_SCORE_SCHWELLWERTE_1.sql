CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.shopper_score_schwellwerte_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
abt_id BIGNUMERIC(38,0) NOT NULL,
arthiertyp_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
ertrag_uplift_schwellwert BIGNUMERIC(20,17),
wrg_id STRING(3) COLLATE 'und:ci',
kaeufer_uplift_schwellwert BIGNUMERIC(20,17),
td_insert TIMESTAMP,
td_update TIMESTAMP
);