CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_EK_CTRY_WK_ITM_BUY_VOL_REC
AS
   SELECT
     client_id,
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

  FROM p_lew_mart_lead.t_agg_ek_ctry_wk_itm_buy_vol_rec
;