CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_ek_ctry_wk_itm_buy_vol_rec_1 AS SELECT client_id,
 item_sid,
 item_id,
 family_cd,
 subitemgroup_id,
 itemgroup_int_id,
 cy_week,
 cy_partial_week,
 cy_month,
 byr,
 buying_volume_val,
 receive_piece_qty
FROM ldl_p_lew_mart_lead.t_agg_ek_ctry_wk_itm_buy_vol_rec_1;