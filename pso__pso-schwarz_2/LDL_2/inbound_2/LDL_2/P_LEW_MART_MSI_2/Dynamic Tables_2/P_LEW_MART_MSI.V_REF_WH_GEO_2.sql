
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_REF_WH_GEO_2 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT
  wh.client_id
, wh.src_wh_id  AS wh_id 
, COALESCE(geo.longitude, main.longitude) AS longitude
, COALESCE(geo.latitude, main.latitude) AS latitude
FROM p_lew_bil_ac.v_warehouse_2 AS wh 
LEFT OUTER JOIN p_lew_core_ac.v_wawi_ref_wh_geo_2 AS geo
ON geo.wh_loc_sid = wh.loc_sid_wh
AND geo.client_id = wh.client_id
LEFT OUTER JOIN (
    SELECT a.longitude
         , a.latitude
         , a.client_id
    FROM p_lew_core_ac.v_wawi_ref_wh_geo_2 AS a
    INNER JOIN p_lew_bil_ac.v_warehouse_2 AS b
    ON a.client_id = b.client_id
    AND a.wh_loc_sid = b.loc_sid_wh
    WHERE b.src_wh_id = 0
    AND b.dwh_actual_fg = 1
) AS main
ON wh.client_id = main.client_id
WHERE wh.src_wh_id <> 0
AND COALESCE(geo.longitude, main.longitude)  IS NOT NULL
AND COALESCE(geo.latitude, main.latitude)  IS NOT NULL
GROUP BY 1,2,3,4
;
