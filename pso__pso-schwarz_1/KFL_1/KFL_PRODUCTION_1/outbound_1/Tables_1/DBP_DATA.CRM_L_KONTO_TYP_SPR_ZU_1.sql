CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_l_konto_typ_spr_zu_1 (
crm_konto_typ_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
crm_konto_typ_bez STRING(20) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);