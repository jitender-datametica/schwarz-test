CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_AGG_STR_DAY_EJR_TXJ_WW_EXT_2 as
   SELECT
       client_id,
   store_id,
   dat_formdate,
   cy_month,
   currency_iso_cd,
   val_retail_asis,
   val_retail_net_asis,
   cnt_customer_asis,
   val_retail_extrapol_asis,
   val_retail_net_extrapol_asis
FROM p_lew_mart_msi.t_agg_str_day_ejr_txj_ww_ext_2;