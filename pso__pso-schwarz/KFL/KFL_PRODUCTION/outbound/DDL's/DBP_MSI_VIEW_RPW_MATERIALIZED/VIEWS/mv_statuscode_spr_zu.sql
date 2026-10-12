CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_rpw_materialized.mv_statuscode_spr_zu (
mandant_id INTEGER,
statuscode_id INTEGER,
spr_id INTEGER,
statuscode_bez STRING(40) COLLATE 'und:ci',
statuscode_bez_kurz STRING(20) COLLATE 'und:ci',
statuscode_bez_lang STRING(100) COLLATE 'und:ci',
system_id INTEGER
);