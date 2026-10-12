CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wg_hierarchie_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
arthiertyp_id BIGNUMERIC(38,0) NOT NULL,
wg_hierarchie_ebene_id BIGNUMERIC(38,0) NOT NULL,
wg_hierarchie_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
wg_hierarchie_bez STRING(50) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);