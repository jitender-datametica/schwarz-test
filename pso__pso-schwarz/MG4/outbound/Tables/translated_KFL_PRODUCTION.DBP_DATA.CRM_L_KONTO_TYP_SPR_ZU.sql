CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_l_konto_typ_spr_zu (
crm_konto_typ_id INTEGER NOT NULL,
spr_id INTEGER NOT NULL,
crm_konto_typ_bez STRING(20) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);