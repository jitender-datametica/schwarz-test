CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_rpw_materialized.mv_vorgangsklasse_spr_zu_2 (
system_id INTEGER,
mandant_id INTEGER,
vorgangsklasse_id STRING(5) COLLATE 'und:ci',
spr_id INTEGER,
vorgangsklasse_bez STRING(40) COLLATE 'und:ci',
vorgangsklasse_bez_kurz STRING(20) COLLATE 'und:ci',
vorgangsklasse_bez_lang STRING(100) COLLATE 'und:ci'
);