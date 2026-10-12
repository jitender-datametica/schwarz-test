CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_ref_wh_geo
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT WH.client_id,
 WH.src_wh_id AS wh_id,
 COALESCE(GEO.longitude, main.longitude) AS longitude,
 COALESCE(GEO.latitude, main.latitude) AS latitude
FROM ldl_p_lew_bil_ac.v_warehouse AS WH
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_wh_geo AS GEO ON WH.loc_sid_wh = GEO.wh_loc_sid AND WH.client_id = GEO.client_id
   
 LEFT JOIN (SELECT A.longitude,
   A.latitude,
   A.client_id
  FROM ldl_p_lew_core_ac.v_wawi_ref_wh_geo AS A
   INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS B ON A.client_id = B.client_id AND A.wh_loc_sid = B.loc_sid_wh
  WHERE B.src_wh_id = 0
   AND B.dwh_actual_fg = 1) AS main ON WH.client_id = main.client_id
WHERE WH.src_wh_id <> 0
 AND COALESCE(GEO.longitude, main.longitude) IS NOT NULL
 AND COALESCE(GEO.latitude, main.latitude) IS NOT NULL
GROUP BY WH.client_id,
 wh_id,
 longitude,
 latitude;
