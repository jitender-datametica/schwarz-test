CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PVT_DAY_TURNOVER_1
(
      client_id
    , orig_item_nr
    , receipt_dt
    , week_id
    , pv_id
    , retail_asis_val
    , piece_asis_qty
    , price_retail_old_pv
    , price_retail_new_pv
    , price_retail_asis
    , partkey
    , uap_filename
    , mod_tmsp
)
AS
   SELECT
         client_id,
   orig_item_nr,
   receipt_dt,
   week_id,
   pv_id,
   retail_asis_val,
   piece_asis_qty,
   price_retail_old_pv,
   price_retail_new_pv,
   price_retail_asis,
   partkey,
   uap_filename,
   mod_tmsp
  FROM p_lew_mart_analytics.t_pvt_day_turnover_1
;