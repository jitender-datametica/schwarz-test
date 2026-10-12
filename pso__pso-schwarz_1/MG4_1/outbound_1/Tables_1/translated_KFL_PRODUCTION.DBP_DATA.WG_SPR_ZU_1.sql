CREATE OR REPLACE TABLE kfl_production_dbp_data.wg_spr_zu_1 (
wg_id INTEGER NOT NULL,
arthiertyp_id INTEGER NOT NULL,
mandant_id INTEGER NOT NULL,
spr_id INTEGER NOT NULL,
wg_bez STRING(400) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='TP1-TP2 - Warengruppen-Sprache Zuordnung');