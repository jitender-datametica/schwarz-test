CREATE OR REPLACE VIEW P_LEW_BIL.V_AGG_STR_DAY_EJR_TXJ_WW_ASIS as
   /*
   #DescStart#
   #$Revision: 6283 $, $LastChangedBy: hwieber $
   #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)
   #DescEnd#
   */
   SELECT
      agg.client_id,
   agg.dat_formdate,
   agg.cy_month,
   agg.orig_store_nr                              AS src_orig_store_nr,
   agg.loc_sid_store,
   agg.val_retail               / b.exchange_rate AS val_retail_asis,
   agg.val_retail_net           / b.exchange_rate AS val_retail_net_asis,
   agg.cnt_customer                               AS cnt_customer_asis,
   (agg.val_rtl_wawi* (-1))     / b.exchange_rate AS val_retail_wawi_asis,
   (agg.val_rtl_net_wawi* (-1)) / b.exchange_rate AS val_retail_net_wawi_asis,
   agg.val_rtl_txj_item         / b.exchange_rate AS val_retail_txj_asis,
   agg.val_rtl_net_txj_item     / b.exchange_rate AS val_retail_net_txj_asis,
   agg.val_rtl_txj_str          / b.exchange_rate AS val_retail_txj_str,
   agg.val_rtl_net_txj_str      / b.exchange_rate AS val_retail_net_txj_str,
   agg.val_rtl_ejr              / b.exchange_rate AS val_retail_ejr_asis,
   agg.val_rtl_net_ejr          / b.exchange_rate AS val_retail_net_ejr_asis,
   agg.cnt_customer_wawi                          AS cnt_customer_wawi_asis,
   agg.cnt_customer_txj                           AS cnt_customer_txj_asis,
   agg.cnt_customer_ejr_he                        AS cnt_customer_ejr_he_asis,
   b.curr_cd_from                                 AS currency_iso_cd
   FROM p_lew_bil.v_agg_sales_store_day AS agg
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist AS b
   ON b.client_id = agg.client_id
   AND CURRENT_DATE BETWEEN b.active_from_dt AND b.active_to_dt
   AND CURRENT_DATE BETWEEN b.dwh_valid_from AND b.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_exchange_rate_type AS c
   ON c.client_id = b.client_id
   AND c.x_rate_type_sid = b.x_rate_type_sid
   AND c.src_kurst = '@BEWE';