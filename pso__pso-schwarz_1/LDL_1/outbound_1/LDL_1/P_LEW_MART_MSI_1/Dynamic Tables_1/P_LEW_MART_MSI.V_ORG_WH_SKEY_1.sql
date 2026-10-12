CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_org_wh_skey_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT DISTINCT WH_SKEY.client_id,
 WH_SKEY.gl_region_id,
 WH.src_wh_id AS wh_id,
 WH_SKEY.aspect_id
FROM ldl_p_lew_core_ac.v_wawi_org_wh_skey_1 AS WH_SKEY
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON WH_SKEY.wh_loc_sid = WH.loc_sid_wh AND WH_SKEY.client_id = WH.client_id
     AND WH.dwh_actual_fg = 1;