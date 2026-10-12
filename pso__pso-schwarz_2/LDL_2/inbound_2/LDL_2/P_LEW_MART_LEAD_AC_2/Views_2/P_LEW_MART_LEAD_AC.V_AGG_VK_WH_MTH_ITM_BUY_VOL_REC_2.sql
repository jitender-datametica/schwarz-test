CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_VK_WH_MTH_ITM_BUY_VOL_REC_2
AS
   SELECT
     client_id,
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

  FROM p_lew_mart_lead.t_agg_vk_wh_mth_itm_buy_vol_rec_2
;