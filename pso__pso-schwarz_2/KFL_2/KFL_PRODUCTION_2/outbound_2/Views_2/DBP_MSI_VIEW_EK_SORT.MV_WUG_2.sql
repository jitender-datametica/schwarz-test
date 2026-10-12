CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_wug_2 AS SELECT V01.mandant_id,
 V01.wug_id,
 V01.wg_id
FROM kfl_production_dbp_view.v_wug_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_wg_filter_zu_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wg_id = V02.wg_id
WHERE V02.wg_filter_id = 11
UNION DISTINCT
SELECT mandant_id,
 - 1 AS wug_id,
 - 1 AS wg_id
FROM kfl_production_dbp_view.v_wug_2;