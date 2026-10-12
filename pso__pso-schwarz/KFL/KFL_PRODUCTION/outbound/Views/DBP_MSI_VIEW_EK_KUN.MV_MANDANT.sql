CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_mandant AS SELECT mandant_sort_id,
 mandant_id,
 mandant_bez,
 mandant_kbez,
 default_wrg,
 mandant_sap_id,
 spaet_lief_tage
FROM kfl_production_dbp_view.v_mandant AS V01
UNION ALL
SELECT 99 AS mandant_sort_id,
 - 1 AS mandant_id,
 'unknown' AS mandant_bez,
 '-' AS mandant_kbez,
 '' AS default_wrg,
 - 1 AS mandant_sap_id,
 - 1 AS spaet_lief_tage
FROM kfl_production_dbp_view.v_mandant AS V02
WHERE mandant_id = 1;