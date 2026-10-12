CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.java_wg_bez_1 (spr_id, wg_id, wg_bez) AS SELECT spr_id,
 wg_id,
 MAX(wg_bez) AS wg_bez
FROM kfl_production_dbp_view.v_wg_spr_zu_1
GROUP BY spr_id,
 wg_id;