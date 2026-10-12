CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_fact_sales_gtin_day_test_1 (division_id, country_id, day_dt, gtin_id,
campaign_id, sales_piece_qty) AS
-- ,CASE WHEN FACT.DAY_DT BETWEEN CAL.CAL_DT_TRANS and CAL.DAY_DT THEN sum(FACT.SALES_PIECE_QTY)  ELSE NULL END PRE_PERIOD_QTY

-- ,CASE WHEN FACT.DAY_DT BETWEEN CAL.CAMPAIGN_START_DT and CAL.CAMPAIGN_END_DT THEN sum(FACT.SALES_PIECE_QTY)  ELSE NULL END TEST_PERIOD_QTY

SELECT FACT.division_id,
 FACT.country_id,
 CAL.day_dt,
 FACT.gtin_id,
 CAL.campaign_id,
 SUM(FACT.sales_piece_qty) AS sales_piece_qty
FROM smp_production_fe_mstr_smp.v_fact_sales_store_supplier_shopper_gtin_day_1 AS FACT
 INNER JOIN smp_production_fe_mstr_smp.v_rel_test_campaign_period_1 AS CAL ON FACT.day_dt >= CAL.cal_dt_trans AND FACT.day_dt
       <= CAL.day_dt AND FACT.division_id = CAL.division_id AND FACT.country_id = CAL.country_id AND FACT.gtin_id = CAL
   .gtin_id
GROUP BY FACT.division_id,
 FACT.country_id,
 CAL.day_dt,
 CAL.campaign_id,
 FACT.gtin_id;