CREATE OR REPLACE VIEW P_LEW_BIL.V_AGG_STORE_DAY_RETURN as
   SELECT a.client_id,
   a.src_orig_store_nr,
   a.loc_sid_store,
   a.orig_wh_nr,
   a.item_sid,
   a.src_subitemgrp_cd,
   a.dwh_cal_dt,
   a.return_reason_mark,
   a.ship_qty,
   a.ship_val,
   a.ship_net_val,
   a.curr_iso_cd
  FROM p_lew_bil.t_agg_store_day_return AS a
;