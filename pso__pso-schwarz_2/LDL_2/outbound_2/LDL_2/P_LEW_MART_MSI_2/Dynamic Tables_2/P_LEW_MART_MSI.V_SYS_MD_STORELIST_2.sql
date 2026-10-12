CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_sys_md_storelist_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT SL.client_id,
 WH.src_wh_id AS wh_id,
 SL.loc_sid_store AS store_id,
 SL.dat_open
FROM ldl_p_lew_bil_ac.v_sys_md_storelist_2 AS SL
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON SL.loc_sid_wh = WH.loc_sid_wh AND SL.client_id = WH.client_id AND WH.dwh_actual_fg
    = 1;