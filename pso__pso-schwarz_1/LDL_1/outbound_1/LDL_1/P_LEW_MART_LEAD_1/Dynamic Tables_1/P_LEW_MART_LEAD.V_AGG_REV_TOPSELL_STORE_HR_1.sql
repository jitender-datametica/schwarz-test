CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.v_agg_rev_topsell_store_hr_1 AS
SELECT HRL.client_id,
 HRL.dat_formdate,
 HRL.loc_sid_store_move_to,
 HRL.wh_loc_sid,
 HRL.wh_id,
 HRL.cy_week,
 CRY.curr_cd_from AS currency_iso_cd,
 HRL.time_hour_id,
 HRL.receipt_for_count_id,
 HRL.qty_piece_ejr,
 HRL.qty_weight_ejr,
 HRL.qty_sold,
 CAST(HRL.val_retail_net_ejr / CRY.exchange_rate AS NUMERIC) AS val_retail_net_ejr
FROM ldl_p_lew_mart_lead.t_agg_rev_topsell_store_hr_1 AS HRL
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_1 AS CRY ON HRL.client_id = CRY.client_id AND CURRENT_DATE
    BETWEEN CRY.active_from_dt AND CRY.active_to_dt AND CURRENT_DATE BETWEEN CRY.dwh_valid_from AND CRY.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_1 AS C ON CRY.client_id = C.client_id AND CRY.x_rate_type_sid = C.x_rate_type_sid
     AND C.src_kurst = '@BEWE';