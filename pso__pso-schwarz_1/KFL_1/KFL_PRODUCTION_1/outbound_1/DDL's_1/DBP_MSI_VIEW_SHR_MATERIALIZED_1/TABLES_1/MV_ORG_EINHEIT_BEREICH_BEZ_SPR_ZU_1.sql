CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_shr_materialized.mv_org_einheit_bereich_bez_spr_zu_1 (
mandant_id INTEGER,
hr_objekt_id INTEGER,
hr_objekt_bez_kurz STRING(10) COLLATE 'und:ci',
hr_objekt_bereich_id INTEGER,
hr_objekt_bereich_bez STRING(100) COLLATE 'und:ci'
);