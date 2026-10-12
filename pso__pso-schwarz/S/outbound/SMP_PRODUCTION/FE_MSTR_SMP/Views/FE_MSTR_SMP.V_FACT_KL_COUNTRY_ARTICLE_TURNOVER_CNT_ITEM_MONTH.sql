CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_fact_kl_country_article_turnover_cnt_item_month (cy_month,
country_id, gtin_id, art_id_ref, art_id_ref_kl, lp_turnover_gross, lp_cnt_item) AS WITH DAYAGG AS (SELECT FACT.day_dt,
   FACT.country_id,
   FACT.gtin_id,
   FACT.art_id_ref,
    CASE
    WHEN FACT.division_id = 'KFL'
    THEN ART.kl_art_id
    ELSE FACT.art_id_ref
    END AS art_id_ref_kl,
   SUM(CASE
     WHEN FACT.shopper_id_ref IS NOT NULL
     THEN FACT.sales_gross_val
     ELSE 0
     END) AS lp_turnover_gross,
   SUM(CASE
     WHEN FACT.shopper_id_ref IS NOT NULL
     THEN FACT.sales_piece_qty
     ELSE 0
     END) AS lp_cnt_item,
   SUM(FACT.sales_gross_val) AS turnover_gross,
   SUM(FACT.sales_piece_qty) AS cnt_item
  FROM smp_production_core.t_fact_sales_store_supplier_shopper_gtin_day AS FACT
   INNER JOIN smp_production_core_rel.t_country AS LAND ON FACT.division_id = LAND.division_id AND FACT.country_id =
     LAND.country_id
   INNER JOIN smp_production_data_shared_kfl.dbp_data_art AS ART ON FACT.art_id_ref = ART.art_id AND FACT.division_id =
       'KFL' AND LAND.division_country_ref = ART.mandant_id AND ART.dat_bis = DATE '9999-12-31'
  WHERE FACT.day_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 366 DAY) AND (CURRENT_DATE)
   AND FACT.division_id = 'KFL'
   AND FACT.sales_piece_qty > 0 -- and art_id_ref_kl='1152811'
 -- and day_dt between '01-JUN-2024' and '30-JUN-2024'

  GROUP BY FACT.day_dt,
   FACT.country_id,
   FACT.gtin_id,
   FACT.art_id_ref,
   art_id_ref_kl) (SELECT MON.cy_month,
   t3.country_id,
   t3.gtin_id,
   t3.art_id_ref,
   t3.art_id_ref_kl,
   SUM(t3.lp_turnover_gross),
   SUM(t3.lp_cnt_item)
  FROM DAYAGG AS t3
   INNER JOIN smp_production_fe_mstr_smp.v_dim_calendarday AS TAG ON t3.day_dt = TAG.cal_dt
   INNER JOIN smp_production_fe_mstr_smp.v_dim_cal_month AS MON ON TAG.cy_month = MON.cy_month
  GROUP BY MON.cy_month,
   t3.country_id,
   t3.gtin_id,
   t3.art_id_ref,
   t3.art_id_ref_kl);