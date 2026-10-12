CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.java_wgi_bez_1 (spr_id, wg_id, wug_id, wgi_bez) AS SELECT
 spr_id,
 wg_id,
 wug_id,
 MAX(wug_bez) AS wgi_bez
FROM kfl_production_dbp_view.v_wug_spr_zu_1
GROUP BY spr_id,
 wg_id,
 wug_id;