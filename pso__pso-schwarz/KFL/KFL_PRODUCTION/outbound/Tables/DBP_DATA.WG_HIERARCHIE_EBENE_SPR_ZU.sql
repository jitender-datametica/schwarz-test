CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wg_hierarchie_ebene_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
arthiertyp_id BIGNUMERIC(38,0) NOT NULL,
wg_hierarchie_ebene_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
wg_hierarchie_ebene_bez STRING(50) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);