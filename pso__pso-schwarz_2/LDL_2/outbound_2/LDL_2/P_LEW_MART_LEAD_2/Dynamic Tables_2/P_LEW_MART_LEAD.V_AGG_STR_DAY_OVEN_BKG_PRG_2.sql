CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.v_agg_str_day_oven_bkg_prg_2 AS
SELECT AGG.client_id,
 AGG.wh_loc_sid,
 AGG.wh_id,
 AGG.loc_sid_store_move_to,
 AGG.aspect_id,
 CRY.curr_cd_from AS currency_iso_cd,
 AGG.oven_id,
 AGG.oven_brand,
 AGG.baking_prog_id,
 AGG.dat_formdate,
 AGG.cy_week,
 AGG.cy_month,
 AGG.busyear,
 AGG.cnt_bkg_prg_fnshd,
 AGG.cnt_bkg_chmbr_idle_tm
FROM ldl_p_lew_mart_lead.t_agg_str_day_oven_bkg_prg_2 AS AGG
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS CRY ON AGG.client_id = CRY.client_id AND CURRENT_DATE
    BETWEEN CRY.active_from_dt AND CRY.active_to_dt AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS C ON CRY.client_id = C.client_id AND CRY.x_rate_type_sid = C.x_rate_type_sid
     AND C.src_kurst = '@BEWE';