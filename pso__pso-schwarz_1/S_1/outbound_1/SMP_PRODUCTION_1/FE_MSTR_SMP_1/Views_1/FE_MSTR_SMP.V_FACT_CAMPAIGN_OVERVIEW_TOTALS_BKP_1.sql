CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_fact_campaign_overview_totals_bkp_1 (report_generated_date,
advertiser_id_smp, campaign_group_name, campaign_name, campaign_id, type, duration_in_days, campaign_start_dt,
campaign_end_dt, attribution_end_dt, channel, country_id, division_id, universe_size, status_1, planned_views,
planned_unit_sold, bid, e_cpm, e_cpc, e_cpa, budget, budget_spent, percent_budget_spent, total_impressions, total_views
, total_shoppers_reached, viewability, view_frequency, total_clicks, ctr, total_units_purchased, conversion_rate,
total_revenue, lifetime_revenue, roas, baseline_sales, sales_uplift) AS SELECT CURRENT_DATE AS report_generated_date,
 C.advertiser_id_smp,
 RG.campaign_group_name,
 C.campaign_name,
 C.campaign_id,
 C.campaign_type_id AS type,
  DATE_DIFF(C.campaign_end_dt, C.campaign_start_dt, DAY) + 1 AS duration_in_days,
 C.campaign_start_dt,
 C.campaign_end_dt,
 C.attribution_end_dt,
 C.channel_id AS channel,
 C.country_id,
 C.division_id,
 NULL AS universe_size,
  CASE
  WHEN CURRENT_DATE BETWEEN C.campaign_start_dt AND C.campaign_end_dt
  THEN 'RUNNING'
  WHEN CURRENT_DATE > C.campaign_end_dt
  THEN 'ENDED'
  WHEN CURRENT_DATE < C.campaign_start_dt
  THEN 'NOT STARTED YET'
  ELSE NULL
  END AS status_1,
  CASE
  WHEN C.campaign_type_id = 'CPM'
  THEN IF(C.advertiser_bid_val = 0, 0, SAFE_DIVIDE(C.budget_val, C.advertiser_bid_val)) * 1000
  ELSE NULL
  END AS planned_views,
  CASE
  WHEN C.campaign_type_id = 'CPA'
  THEN IF(C.advertiser_bid_val = 0, 0, SAFE_DIVIDE(C.budget_val, C.advertiser_bid_val))
  ELSE NULL
  END AS planned_unit_sold,
 C.advertiser_bid_val AS bid,
  IF(C.view_qty = 0, 0, SAFE_DIVIDE(C.budget_spent_val, C.view_qty)) * 1000 AS e_cpm,
 IF(C.click_qty = 0, 0, SAFE_DIVIDE(C.budget_spent_val, C.click_qty)) AS e_cpc,
 IF(C.sales_qty = 0, 0, SAFE_DIVIDE(C.budget_spent_val, C.sales_qty)) AS e_cpa,
 C.budget_val AS budget,
 C.budget_spent_val AS budget_spent,
 IF(C.budget_val = 0, 0, SAFE_DIVIDE(C.budget_spent_val, C.budget_val)) AS percent_budget_spent,
 C.impression_qty AS total_impressions,
 C.view_qty AS total_views,
 C.shopper_qty AS total_shoppers_reached,
 IF(C.impression_qty = 0, 0, SAFE_DIVIDE(C.view_qty, C.impression_qty)) AS viewability,
 IF(C.shopper_qty = 0, 0, SAFE_DIVIDE(C.view_qty, C.shopper_qty)) AS view_frequency,
 C.click_qty AS total_clicks,
 IF(C.view_qty = 0, 0, SAFE_DIVIDE(C.click_qty, C.view_qty)) AS ctr,
 C.sales_qty AS total_units_purchased,
 IF(C.click_qty = 0, 0, SAFE_DIVIDE(C.conversion_qty, C.click_qty)) AS conversion_rate,
 C.sales_val AS total_revenue,
 C.lifetime_revenue_val AS lifetime_revenue,
 IF(C.budget_spent_val = 0, 0, SAFE_DIVIDE(C.sales_val, C.budget_spent_val)) AS roas,
 NULL AS baseline_sales,
 NULL AS sales_uplift
FROM smp_production_core.t_dim_campaign_1 AS C
 LEFT JOIN smp_production_core_rel.t_campaign_1 AS RC ON C.campaign_id = RC.campaign_id
 LEFT JOIN smp_production_core_rel.t_campaign_group_1 AS RG ON RC.campaign_group_id = RG.campaign_group_id
WHERE C.campaign_start_dt >= DATE '2023-01-01'
 AND LOWER(C.campaign_name) NOT LIKE LOWER('%TEST_1%')
UNION DISTINCT
SELECT CURRENT_DATE AS report_generated_date,
 C.advertiser_id_smp,
 RG.campaign_group_name,
 'TOTAL' AS campaign_name_,
 RG.campaign_group_id AS campaign_id_,
 MIN(C.campaign_type_id) AS campaign_type,
 DATE_DIFF(MAX(C.campaign_end_dt), MIN(C.campaign_start_dt), DAY) AS duration_in_days,
 MIN(C.campaign_start_dt) AS campaign_start_dt,
 MAX(C.campaign_end_dt) AS campaign_end_dt,
 CAST(CAST(NULL AS STRING) AS DATE) AS attribution_end_dt,
 C.channel_id AS channel,
 C.country_id,
 C.division_id,
 NULL AS universe_size,
  CASE
  WHEN CURRENT_DATE BETWEEN C.campaign_start_dt AND C.campaign_end_dt
  THEN 'RUNNING'
  WHEN CURRENT_DATE > C.campaign_end_dt
  THEN 'ENDED'
  WHEN CURRENT_DATE < C.campaign_start_dt
  THEN 'NOT STARTED YET'
  ELSE NULL
  END AS status_1,
 SUM(CASE
   WHEN C.campaign_type_id = 'CPM'
   THEN IF(C.advertiser_bid_val = 0, 0, SAFE_DIVIDE(C.budget_val, C.advertiser_bid_val)) * 1000
   ELSE NULL
   END) AS planned_views,
 CAST(NULL AS BIGNUMERIC) AS planned_unit_sold,
 AVG(C.advertiser_bid_val) AS bid,
  IF(SUM(C.view_qty) = 0, 0, SAFE_DIVIDE(SUM(C.budget_spent_val), SUM(C.view_qty))) * 1000 AS e_cpm,
 IF(SUM(C.click_qty) = 0, 0, SAFE_DIVIDE(SUM(C.budget_spent_val), SUM(C.click_qty))) AS e_cpc,
 IF(SUM(C.sales_qty) = 0, 0, SAFE_DIVIDE(SUM(C.budget_spent_val), SUM(C.sales_qty))) AS e_cpa,
 SUM(C.budget_val) AS budget,
 SUM(C.budget_spent_val) AS budget_spent,
 IF(SUM(C.budget_val) = 0, 0, SAFE_DIVIDE(SUM(C.budget_spent_val), SUM(C.budget_val))) AS percent_budget_spent,
 SUM(C.impression_qty) AS total_impressions,
 SUM(C.view_qty) AS total_views,
 SUM(C.shopper_qty) AS total_shoppers_reached,
 IF(SUM(C.impression_qty) = 0, 0, SAFE_DIVIDE(SUM(C.view_qty), SUM(C.impression_qty))) AS viewability,
 IF(SUM(C.shopper_qty) = 0, 0, SAFE_DIVIDE(SUM(C.view_qty), SUM(C.shopper_qty))) AS view_frequency,
 SUM(C.click_qty) AS total_clicks,
 IF(SUM(C.view_qty) = 0, 0, SAFE_DIVIDE(SUM(C.click_qty), SUM(C.view_qty))) AS ctr,
 SUM(C.sales_qty) AS total_units_purchased,
 IF(SUM(C.click_qty) = 0, 0, SAFE_DIVIDE(SUM(C.conversion_qty), SUM(C.click_qty))) AS conversion_rate,
 SUM(C.sales_val) AS total_revenue,
 SUM(C.lifetime_revenue_val) AS lifetime_revenue,
 IF(SUM(C.budget_spent_val) = 0, 0, SAFE_DIVIDE(SUM(C.sales_val), SUM(C.budget_spent_val))) AS roas,
 NULL AS baseline_sales,
 NULL AS sales_uplift
FROM smp_production_core.t_dim_campaign_1 AS C
 LEFT JOIN smp_production_core_rel.t_campaign_1 AS RC ON C.campaign_id = RC.campaign_id
 LEFT JOIN smp_production_core_rel.t_campaign_group_1 AS RG ON RC.campaign_group_id = RG.campaign_group_id
WHERE C.campaign_start_dt >= DATE '2023-01-01'
 AND LOWER(C.campaign_name) NOT LIKE LOWER('%TEST_1%')
 AND RG.campaign_group_name IS NOT NULL
GROUP BY report_generated_date,
 C.advertiser_id_smp,
 RG.campaign_group_name,
 campaign_name_,
 campaign_id_,
 attribution_end_dt,
 channel,
 C.country_id,
 C.division_id,
 universe_size,
 status_1;