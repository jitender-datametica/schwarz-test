CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_in_l_wg_2 (mandant_id, in_wg_id, in_wg_struktur_id) AS SELECT
 mandant_id,
 in_wg_id,
 in_wg_struktur_id
FROM kfl_production_dbp_view.v_in_l_wg_2 AS V01
WHERE SUBSTR(in_wg_id, 1, 1) = 'W';