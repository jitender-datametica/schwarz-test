CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.java_wgi_bez_2 AS SELECT spr_id,
 wg_id,
 wug_id,
 MAX(wug_bez) AS wgi_bez
FROM kfl_production_dbp_view.v_wug_spr_zu_2
GROUP BY spr_id,
 wg_id,
 wug_id;