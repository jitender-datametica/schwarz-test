CREATE OR REPLACE VIEW P_LEW_BIL_AC.V_AGG_STORE_MTH_TURNOVER_EXT_1
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
   , cnt_customer
   , cnt_customer_extrapol AS cnt_customer_extrapol
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
   FROM p_lew_bil.v_agg_store_mth_turnover_ext_1;
