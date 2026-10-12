CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_fact_kl_country_gtin_turnover_cnt_item_bkp_2 (day_dt, country_id,
gtin_id, art_id_ref, lp_turnover_gross, lp_cnt_item, turnover_gross, cnt_item_2) AS SELECT day_dt,
 country_id,
 gtin_id,
 art_id_ref,
 SUM(CASE
   WHEN shopper_id_ref IS NOT NULL
   THEN sales_gross_val
   ELSE 0
   END) AS lp_turnover_gross,
 SUM(CASE
   WHEN shopper_id_ref IS NOT NULL
   THEN sales_piece_qty
   ELSE 0
   END) AS lp_cnt_item,
 SUM(sales_gross_val) AS turnover_gross,
 SUM(sales_piece_qty) AS cnt_item_2
FROM smp_production_core.t_fact_sales_store_supplier_shopper_gtin_day_2 AS FACT
WHERE day_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY) AND (CURRENT_DATE)
 AND division_id = 'KFL'
 AND sales_piece_qty > 0
GROUP BY day_dt,
 country_id,
 gtin_id,
 art_id_ref;