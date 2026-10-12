CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.v_agg_store_day_oven_events AS
SELECT AGG.client_id,
 AGG.wh_loc_sid,
 AGG.wh_id,
 AGG.loc_sid_store_move_to,
 AGG.aspect_id,
 CRY.curr_cd_from AS currency_iso_cd,
 AGG.oven_id,
 AGG.oven_brand,
 AGG.dat_formdate,
 AGG.cy_week,
 AGG.cy_month,
 AGG.busyear,
 AGG.cnt_cleanings,
 AGG.cnt_baking_last_hour,
 AGG.no_baking_afternoon_fg,
 AGG.cnt_chmb_door_open,
 AGG.cnt_mantn_preheat_temprtr,
 AGG.cnt_cncld_pgm,
 AGG.cnt_bake_bfr_str_open,
 AGG.connected_fg,
 AGG.cnt_late_door_opening,
 AGG.cnt_bakings_morning,
 AGG.cnt_bakings_afternoon
FROM ldl_p_lew_mart_lead.t_agg_store_day_oven_events AS AGG
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist AS CRY ON AGG.client_id = CRY.client_id AND CURRENT_DATE
    BETWEEN CRY.active_from_dt AND CRY.active_to_dt AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type AS C ON CRY.client_id = C.client_id AND CRY.x_rate_type_sid = C.x_rate_type_sid
     AND C.src_kurst = '@BEWE';