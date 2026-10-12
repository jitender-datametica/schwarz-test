CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_AGG_STR_MTH_EJR_TXJ_WW_ASIS_1 as
   SELECT
     client_id,
   cy_month                        AS    month_id,
   orig_store_nr,
   store_id,
   Sum(val_retail_asis)            AS    val_retail_asis,
   Sum(val_retail_net_asis)        AS    val_retail_net_asis,
   Sum(cnt_customer_asis)          AS    cnt_customer_asis,
   Sum(val_retail_wawi_asis)       AS    val_retail_wawi_asis,
   Sum(val_retail_net_wawi_asis)   AS    val_retail_net_wawi_asis,
   Sum(val_retail_txj_asis)        AS    val_retail_txj_asis,
   Sum(val_retail_net_txj_asis)    AS    val_retail_net_txj_asis,
   Sum(val_retail_txj_str)         AS    val_retail_txj_str,
   Sum(val_retail_net_txj_str)     AS    val_retail_net_txj_str,
   Sum(val_retail_ejr_asis)        AS    val_retail_ejr_asis,
   Sum(val_retail_net_ejr_asis)    AS    val_retail_net_ejr_asis,
   Sum(cnt_customer_wawi_asis)     AS    cnt_customer_wawi_asis,
   Sum(cnt_customer_txj_asis)      AS    cnt_customer_txj_asis,
   Sum(cnt_customer_ejr_he_asis)   AS    cnt_customer_ejr_he_asis,
   currency_iso_cd
   FROM p_lew_mart_msi.v_agg_str_day_ejr_txj_ww_asis_1
   GROUP BY
     client_id
     ,month_id
     ,orig_store_nr
     ,store_id
     ,currency_iso_cd
;