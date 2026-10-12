CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_MISS_ITM_WH_DAY_ASIS_1
AS
   SELECT
   client_id,
   wh_loc_sid,
   wh_id,
   item_sid,
   dat_formdate,
   cy_month,
   cy_partial_week_id,
   cy_week,
   busyear,
   miss_itm_wh_fg,
   miss_itm_store_15_fg,
   miss_item_fg
       FROM p_lew_mart_lead.t_miss_itm_wh_day_asis_1
;