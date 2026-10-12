CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_vk_wh_mth_itm_buy_vol_rec_2 AS SELECT client_id,
 loc_sid_wh,
 wh_id,
 item_sid,
 item_id,
 family_cd,
 subitemgroup_id,
 itemgroup_int_id,
 cy_month,
 byr,
 sales_volume_val,
 sales_piece_qty
FROM ldl_p_lew_mart_lead.t_agg_vk_wh_mth_itm_buy_vol_rec_2;