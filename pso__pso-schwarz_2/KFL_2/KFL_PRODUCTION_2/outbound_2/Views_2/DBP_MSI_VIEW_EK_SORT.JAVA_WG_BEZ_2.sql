CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.java_wg_bez_2 AS SELECT spr_id,
 wg_id,
 MAX(wg_bez) AS wg_bez
FROM kfl_production_dbp_view.v_wg_spr_zu_2
GROUP BY spr_id,
 wg_id;