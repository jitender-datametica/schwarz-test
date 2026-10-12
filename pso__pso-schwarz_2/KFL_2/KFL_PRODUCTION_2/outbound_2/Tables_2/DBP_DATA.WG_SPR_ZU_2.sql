CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wg_spr_zu_2 (
wg_id BIGNUMERIC(38,0) NOT NULL,
arthiertyp_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
wg_bez STRING(400) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='TP1-TP2 - Warengruppen-Sprache Zuordnung');