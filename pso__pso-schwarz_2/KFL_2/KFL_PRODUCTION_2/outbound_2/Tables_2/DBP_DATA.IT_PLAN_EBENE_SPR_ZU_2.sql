CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.it_plan_ebene_spr_zu_2 (
it_plan_ebene_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
it_plan_ebene_kbez STRING(10) COLLATE 'und:ci',
it_plan_ebene_bez STRING(50) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);