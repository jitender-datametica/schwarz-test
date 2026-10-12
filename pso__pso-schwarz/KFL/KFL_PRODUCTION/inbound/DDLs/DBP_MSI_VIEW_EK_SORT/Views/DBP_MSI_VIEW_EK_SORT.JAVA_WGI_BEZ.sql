CREATE OR REPLACE VIEW dbp_msi_view_ek_sort.java_wgi_bez
 AS
 SELECT
 spr_id,
 wg_id,
 wug_id,
 Max(wug_bez) wgi_bez
 FROM dbp_view.v_wug_spr_zu
 GROUP BY 1,2,3;