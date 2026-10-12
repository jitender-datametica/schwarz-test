CREATE OR REPLACE VIEW dbp_msi_view_ek_sort.java_wgi_bez_1
 AS
 SELECT
 spr_id,
 wg_id,
 wug_id,
 Max(wug_bez) wgi_bez
 FROM dbp_view.v_wug_spr_zu_1
 GROUP BY 1,2,3;