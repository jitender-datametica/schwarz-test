CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_l_in_wg_1 AS SELECT in_wg_id,
 MAX(in_wg_struktur_id) AS in_wg_ebene6_id
FROM kfl_production_dbp_view.v_in_l_wg_1
GROUP BY in_wg_id;