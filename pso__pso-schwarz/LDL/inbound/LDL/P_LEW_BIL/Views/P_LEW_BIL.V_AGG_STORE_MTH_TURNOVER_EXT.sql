CREATE OR REPLACE VIEW P_LEW_BIL.V_AGG_STORE_MTH_TURNOVER_EXT
(
 client_id
, src_orig_store_nr
, loc_sid_store
, cy_month
, currency_iso_cd
, cnt_customer
, cnt_customer_extrapol
, val_rtl
, val_rtl_net
, val_rtl_extrapol
, val_rtl_net_extrapol
, val_rtl_kpges
, val_rtl_net_kpges
, val_rtl_wawi
, val_rtl_net_wawi
, val_rtl_txj
, val_rtl_net_txj
, val_rtl_ejr
, val_rtl_net_ejr
)
AS
   SELECT
    client_id
   , src_orig_store_nr
   , loc_sid_store
   , cy_month
   , currency_iso_cd
   , Sum(cnt_customer)
   , Sum(cnt_customer_extrapol) AS cnt_customer_extrapol
   , Sum(val_rtl)
   , Sum(val_rtl_net)
   , Sum(val_rtl_extrapol)
   , Sum(val_rtl_net_extrapol)
   , Sum(val_rtl_kpges)
   , Sum(val_rtl_net_kpges)
   , Sum(val_rtl_wawi)
   , Sum(val_rtl_net_wawi)
   , Sum(val_rtl_txj)
   , Sum(val_rtl_net_txj)
   , Sum(val_rtl_ejr)
   , Sum(val_rtl_net_ejr)

  FROM p_lew_bil.t_agg_store_day_turnover_ext
  GROUP BY
    client_id
  , src_orig_store_nr
  , loc_sid_store
  , cy_month
  , currency_iso_cd;
