CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.wg_wechsel_agg_verarb (
mandant_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0) NOT NULL,
arthiertyp_id BIGNUMERIC(38,0) NOT NULL,
wg_id_alt BIGNUMERIC(38,0),
wg_id_neu BIGNUMERIC(38,0),
verarb_dat DATE,
job_skript STRING(100) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);