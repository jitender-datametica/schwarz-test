CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lis_plan_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lis_planzahl_id BIGNUMERIC(38,0) NOT NULL,
lis_plan_typ_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
lis_planzahl_bez STRING(60) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);