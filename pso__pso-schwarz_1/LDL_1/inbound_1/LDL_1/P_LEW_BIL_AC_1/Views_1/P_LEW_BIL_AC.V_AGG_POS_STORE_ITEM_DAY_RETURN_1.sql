CREATE OR REPLACE VIEW P_LEW_BIL_AC.V_AGG_POS_STORE_ITEM_DAY_RETURN_1
AS
   SELECT

     client_id,
   loc_sid_store,
   item_sid,
   dwh_cal_dt,
   return_qty,
   return_reason_cd
  FROM p_lew_bil.t_agg_pos_store_item_day_return_1

;