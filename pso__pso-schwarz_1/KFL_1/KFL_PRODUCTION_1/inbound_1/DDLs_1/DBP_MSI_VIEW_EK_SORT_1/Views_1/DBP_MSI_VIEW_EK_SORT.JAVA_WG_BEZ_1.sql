CREATE OR REPLACE VIEW dbp_msi_view_ek_sort.java_wg_bez_1
 AS
 SELECT
 spr_id,
 wg_id,
 Max(wg_bez) wg_bez
 FROM dbp_view.v_wg_spr_zu_1
 GROUP BY 1,2;