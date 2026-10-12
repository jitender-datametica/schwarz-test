CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_ref_client_geo
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT GEO.client_id,
 GEO.longitude,
 GEO.latitude
FROM ldl_p_lew_core_ac.v_wawi_ref_wh_geo AS GEO
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON GEO.client_id = WH.client_id AND GEO.wh_loc_sid = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
WHERE WH.src_wh_id = 0;