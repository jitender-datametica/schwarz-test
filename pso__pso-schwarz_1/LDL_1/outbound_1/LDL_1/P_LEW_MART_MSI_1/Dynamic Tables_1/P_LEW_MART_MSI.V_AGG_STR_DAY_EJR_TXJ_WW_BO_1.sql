CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_agg_str_day_ejr_txj_ww_bo_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
-- wird lt. AccCount nicht referenziert
 -- Replicate p_process_view.v_mast_migrt_core_wh
 SELECT A.loc_sid AS store_id
 ,
 A.client_id,
 A.dwh_cal_dt AS dat_formdate,
  CASE
  WHEN ez.eins = 1
  THEN A.cy_month
  ELSE B.cy_month
  END AS cy_month,
 NULL AS orig_store_nr,
  CASE
  WHEN ez.eins = 1
  THEN A.cnt_customer
  ELSE B.cnt_customer
  END AS cnt_customer,
  CASE
  WHEN ez.eins = 1
  THEN A.cnt_customer_wawi
  ELSE B.cnt_customer_wawi
  END AS cnt_customer_wawi,
  CASE
  WHEN ez.eins = 1
  THEN A.cnt_customer_pos_receipt
  ELSE B.cnt_customer_ejr_he
  END AS cnt_customer_ejr_he,
  CASE
  WHEN ez.eins = 1
  THEN A.cnt_customer_pos_statistic
  ELSE B.cnt_customer_ejr_st
  END AS cnt_customer_ejr_st,
  CASE
  WHEN ez.eins = 1
  THEN A.cnt_customer_txj
  ELSE B.cnt_customer_txj
  END AS cnt_customer_txj,
  CASE
  WHEN ez.eins = 1
  THEN A.sales_gross_val
  ELSE COALESCE(B.val_retail, 0)
  END AS val_retail,
  CASE
  WHEN ez.eins = 1
  THEN A.sales_net_val
  ELSE COALESCE(B.val_retail_net, 0)
  END AS val_retail_net,
  CASE
  WHEN ez.eins = 1
  THEN A.sales_gross_val_wawi
  ELSE B.val_rtl_wawi
  END AS val_rtl_wawi,
  CASE
  WHEN ez.eins = 1
  THEN A.sales_net_val_wawi
  ELSE B.val_rtl_net_wawi
  END AS val_rtl_net_wawi,
  CASE
  WHEN ez.eins = 1
  THEN A.sales_gross_val_pos
  ELSE B.val_rtl_ejr
  END AS val_rtl_ejr,
  CASE
  WHEN ez.eins = 1
  THEN A.sales_net_val_pos
  ELSE B.val_rtl_net_ejr
  END AS val_rtl_net_ejr,
  CASE
  WHEN ez.eins = 1
  THEN A.sales_gross_val_txj_store
  ELSE B.val_rtl_txj_str
  END AS val_rtl_txj_str,
  CASE
  WHEN ez.eins = 1
  THEN A.sales_net_val_txj_store
  ELSE B.val_rtl_net_txj_str
  END AS val_rtl_net_txj_str,
  CASE
  WHEN ez.eins = 1
  THEN A.sales_gross_val_txj_item
  ELSE B.val_rtl_txj_item
  END AS val_rtl_txj_item,
  CASE
  WHEN ez.eins = 1
  THEN A.sales_net_val_txj_item
  ELSE B.val_rtl_net_txj_item
  END AS val_rtl_net_txj_item,
  CASE
  WHEN ez.eins = 1
  THEN A.vat_val_pos
  ELSE B.val_vatamount_ejr
  END AS val_vatamount_ejr,
  CASE
  WHEN ez.eins = 1
  THEN A.vat_val_txj
  ELSE B.val_vatamount_txj
  END AS val_vatamount_txj,
  CASE
  WHEN ez.eins = 1
  THEN A.vat_val_txj_net
  ELSE B.val_vatamount_net_txj
  END AS val_vatamount_net_txj
FROM ldl_p_lew_bil_ac.v_agg_pos_txj_wawi_store_day_1 AS A
 INNER JOIN (SELECT 1 AS eins
   UNION ALL
   SELECT 2 AS eins) AS ez ON TRUE
 LEFT JOIN ldl_p_lew_bil_ac.v_agg_sales_store_day_1 AS B ON A.client_id = B.client_id AND A.loc_sid = B.loc_sid_store AND
   A.dwh_cal_dt = B.dat_formdate
WHERE B.client_id = 21
 AND A.dwh_cal_dt >= DATE '2016-09-05'
 AND B.client_id IN (1, 33)
 AND ez.eins IN (1, 2);

