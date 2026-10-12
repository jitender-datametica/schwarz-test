CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_ref_wh_management_region
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT REG.client_id,
 WH.src_wh_id AS wh_id,
 REG.managing_board_int,
 REG.managing_director_sales,
 REG.managing_director_region,
 REG.region_id
FROM ldl_p_lew_core_ac.v_wawi_ref_wh_management_region AS REG
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON REG.wh_loc_sid = WH.loc_sid_wh AND REG.client_id = WH.client_id AND WH
   .dwh_actual_fg = 1
GROUP BY REG.client_id,
 wh_id,
 REG.managing_board_int,
 REG.managing_director_sales,
 REG.managing_director_region,
 REG.region_id;