CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_order_times_wh_2 (country_lidl_cd, wh_id, range_zone_id, range_desc) AS SELECT
 CLNT.src_country_lidl_cd AS country_lidl_cd,
 LOC.src_wh_id AS wh_id,
 DRW.src_range_zone_id AS range_zone_id,
 DRW.order_time_range_name AS range_desc
FROM ldl_p_lew_core_ac.v_warehouse_order_time_range_2 AS DRW
 INNER JOIN ldl_p_lew_core_ac.v_location_2 AS LOC ON DRW.loc_sid_wh = LOC.loc_sid AND DRW.client_id = LOC.client_id
 INNER JOIN ldl_p_lew_core_ac.v_client_2 AS CLNT ON DRW.client_id = CLNT.client_id;