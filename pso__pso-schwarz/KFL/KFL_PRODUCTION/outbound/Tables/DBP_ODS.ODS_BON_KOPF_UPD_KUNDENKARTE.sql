CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods.ods_bon_kopf_upd_kundenkarte (
bon_id STRING(25) NOT NULL,
bon_dat DATE NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
bon_end_date DATETIME NOT NULL,
kundenkarte_id STRING(255) COLLATE 'und:ci',
insert_date DATETIME NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
bon_day BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY mandant_id, wup_id;