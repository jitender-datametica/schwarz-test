CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_fact_sales_gtin_day (division_id, country_id, day_dt, gtin_id,
campaign_id, cal_dt_trans, sales_piece_qty) AS SELECT FACT.division_id,
 FACT.country_id,
 FACT.day_dt,
 FACT.gtin_id,
 CAL.campaign_id,
 CAL.cal_dt_trans,
 SUM(FACT.sales_piece_qty) AS sales_piece_qty
FROM smp_production_fe_mstr_smp.v_fact_sales_store_supplier_shopper_gtin_day AS FACT
 LEFT JOIN smp_production_fe_mstr_smp.v_cal_test_campaign_period AS CAL ON FACT.day_dt = CAL.day_dt AND FACT.division_id
     = CAL.division_id AND FACT.country_id = CAL.country_id
WHERE FACT.day_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 50 DAY) AND (CURRENT_DATE)
GROUP BY FACT.division_id,
 FACT.country_id,
 FACT.day_dt,
 FACT.gtin_id,
 CAL.campaign_id,
 CAL.cal_dt_trans;