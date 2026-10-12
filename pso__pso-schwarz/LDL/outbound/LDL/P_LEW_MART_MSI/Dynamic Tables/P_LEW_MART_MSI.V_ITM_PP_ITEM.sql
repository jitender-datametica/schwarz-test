CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_itm_pp_item
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT A.client_id,
 WH.src_wh_id AS wh_id_pp,
 A.pick_area_id AS picking_area_nr_pp,
 COALESCE(ITMP.dwh_orig_item_nr, ITMP.wawi_dwh_orig_item_nr) AS orig_item_nr_pp,
 COALESCE(ITMP.dwh_case_size, ITMP.wawi_dwh_case_size) AS case_size_pp,
 ITMP.item_sid_map AS item_id,
 A.missing_status_start_tmsp AS timestamp_from_pp,
 A.missing_status_end_tmsp AS timestamp_until_pp,
 A.dwh_cal_dt AS dat_sys,
 A.missing_status_cd AS end_cd_pp,
 A.missing_item_status_cd AS item_status_pp
FROM ldl_p_lew_core_ac.v_missing_item_wh_day_status AS A
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON A.client_id = WH.client_id AND A.loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key AS ITMP ON A.client_id = ITMP.client_id AND A.item_sid = ITMP.item_sid;