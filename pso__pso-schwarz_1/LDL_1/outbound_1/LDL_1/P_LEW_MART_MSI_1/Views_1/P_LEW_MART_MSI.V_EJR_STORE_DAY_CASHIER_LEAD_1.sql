/* #DescStart#	
   #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)	
   #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_store_day_cashier_lead_1 (client_id, store_id, dat_formdate,
val_shouldbe_turnover, cnt_customer, cnt_pos_total, val_servicetime, val_avg_purchase, val_pos_per_minute,
val_pos_per_purchase) AS SELECT client_id,
 store_id,
 dat_formdate,
 SUM(val_shouldbe_turnover) AS val_shouldbe_turnover,
 SUM(cnt_customer) AS cnt_customer,
 SUM(cnt_pos_total) AS cnt_pos_total,
 SUM(val_servicetime) AS val_servicetime,
  CAST(SUM(val_shouldbe_turnover) AS BIGNUMERIC) / CASE
   WHEN CAST(SUM(cnt_customer) AS BIGNUMERIC) = 0
   THEN NULL
   ELSE CAST(SUM(cnt_customer) AS BIGNUMERIC)
   END AS val_avg_purchase,
  CAST(SUM(cnt_pos_total) AS BIGNUMERIC) / CASE
   WHEN CAST(SUM(val_servicetime) AS BIGNUMERIC) = 0
   THEN NULL
   ELSE CAST(SUM(val_servicetime) AS BIGNUMERIC)
   END AS val_pos_per_minute,
  CAST(SUM(cnt_pos_total) AS BIGNUMERIC) / CASE
   WHEN CAST(SUM(cnt_customer) AS BIGNUMERIC) = 0
   THEN NULL
   ELSE CAST(SUM(cnt_customer) AS BIGNUMERIC)
   END AS val_pos_per_purchase
FROM ldl_p_lew_mart_msi.v_ejr_store_day_cashier_stat_1 AS V
GROUP BY client_id,
 store_id,
 dat_formdate;