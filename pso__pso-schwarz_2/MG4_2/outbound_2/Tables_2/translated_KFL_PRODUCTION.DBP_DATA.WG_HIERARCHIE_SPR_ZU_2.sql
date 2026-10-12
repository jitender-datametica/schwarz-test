CREATE OR REPLACE TABLE kfl_production_dbp_data.wg_hierarchie_spr_zu_2 (
mandant_id INTEGER NOT NULL,
arthiertyp_id INTEGER NOT NULL,
wg_hierarchie_ebene_id INTEGER NOT NULL,
wg_hierarchie_id INTEGER NOT NULL,
spr_id INTEGER NOT NULL,
wg_hierarchie_bez STRING(50) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);