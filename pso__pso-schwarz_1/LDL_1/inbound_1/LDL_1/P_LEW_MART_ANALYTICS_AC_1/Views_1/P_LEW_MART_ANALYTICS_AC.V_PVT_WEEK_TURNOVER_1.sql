CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PVT_WEEK_TURNOVER_1
(
      client_id
    , orig_item_nr
    , week_id
    , pv_id
    , price_retail_old_pv
    , price_retail_new_pv
    , retail_asis_val
    , retail_asis_val_smoothed
    , piece_asis_qty
    , piece_asis_qty_smoothed
    , partkey
    , uap_filename
    , mod_tmsp
)
AS
   SELECT
         client_id,
   orig_item_nr,
   week_id,
   pv_id,
   price_retail_old_pv,
   price_retail_new_pv,
   retail_asis_val,
   retail_asis_val_smoothed,
   piece_asis_qty,
   piece_asis_qty_smoothed,
   partkey,
   uap_filename,
   mod_tmsp
  FROM p_lew_mart_analytics.t_pvt_week_turnover_1
;