CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.java_wg_bez (spr_id, wg_id, wg_bez) AS SELECT spr_id,
 wg_id,
 MAX(wg_bez) AS wg_bez
FROM kfl_production_dbp_view.v_wg_spr_zu
GROUP BY spr_id,
 wg_id;