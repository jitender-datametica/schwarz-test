CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_fact_sales_campaign_pg_2 (division_id, country_id, campaign_id,
campaign_type_id, banner_id, gtin_id, article_nr_ext, iroas_pct, incr_conversion, regular_unit_price, actual_unit_price
, amount_val, unit_qty, billed_conversions, campaign_gtin_retail_unit_price, incr_revenue, campaign_spent, cpa) AS
SELECT TAS.division_id,
 TAS.country_id,
 TAS.campaign_id,
 TAS.campaign_type_id,
 TAS.banner_id,
 TAS.gtin_id,
 TAS.article_nr_ext,
 TCS.iroas_pct,
 SUM(TCS.incr_conversion) AS incr_conversion,
 MAX(TAS.regular_unit_price) AS regular_unit_price,
 MAX(TAS.actual_unit_price) AS actual_unit_price,
 SUM(TAS.amount_val) AS amount_val,
 SUM(TAS.unit_qty) AS unit_qty,
 SUM(TCS.incr_conversion * TAS.unit_qty) AS billed_conversions,
 MAX(TGT.campaign_gtin_regular_unit_price) AS campaign_gtin_retail_unit_price,
 SUM(TCS.incr_conversion * TGT.campaign_gtin_regular_unit_price) AS incr_revenue,
 SUM(TDC.budget_spent_val) AS campaign_spent,
 SUM(TDC.budget_spent_val / (TCS.incr_conversion * TAS.unit_qty)) AS cpa
FROM smp_production_core_rel.t_smp_attributed_sales_2 AS TAS
 INNER JOIN smp_production_core.t_ab_campaign_setup_2 AS TCS ON TAS.division_id = TCS.division_id AND TAS.campaign_id =
    TCS.campaign_id AND TAS.country_id = TCS.country_id
 INNER JOIN smp_production_core_rel.t_campaign_gtin_2 AS TGT ON TAS.country_id = TGT.country_id AND TAS.division_id = TGT
     .division_id AND TAS.campaign_id = TGT.campaign_id AND TAS.gtin_id = TGT.gtin_id
 INNER JOIN smp_production_core.t_dim_campaign_2 AS TDC ON TAS.country_id = TDC.country_id AND TAS.division_id = TDC.division_id
     AND TAS.campaign_id = TDC.campaign_id
GROUP BY TAS.division_id,
 TAS.country_id,
 TAS.campaign_id,
 TAS.campaign_type_id,
 TAS.banner_id,
 TAS.gtin_id,
 TAS.article_nr_ext,
 TCS.iroas_pct;