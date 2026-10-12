CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_fact_campaign_overview_totals_test_2 (campaign_id, duration_in_days,
campaign_type_id, campaign_start_dt, campaign_end_dt, attribution_end_dt, channel_id, country_id, division_id, status_2,
advertiser_id_smp, advertiser_bid_val, budget_spent_val, view_qty, click_qty, sales_qty, conversion_qty, shopper_qty,
budget_val, sales_val, lifetime_revenue_val, impression_qty) AS SELECT campaign_id,
  DATE_DIFF(campaign_end_dt, campaign_start_dt, DAY) + 1 AS duration_in_days,
 campaign_type_id,
 campaign_start_dt,
 campaign_end_dt,
 attribution_end_dt,
 channel_id,
 country_id,
 division_id,
  CASE
  WHEN CURRENT_DATE BETWEEN campaign_start_dt AND campaign_end_dt
  THEN 'RUNNING'
  WHEN CURRENT_DATE > campaign_end_dt
  THEN 'ENDED'
  WHEN CURRENT_DATE < campaign_start_dt
  THEN 'NOT STARTED YET'
  ELSE NULL
  END AS status_2,
 advertiser_id_smp,
 advertiser_bid_val,
 budget_spent_val,
 view_qty,
 click_qty,
 sales_qty,
 conversion_qty,
 shopper_qty,
 budget_val,
 sales_val,
 lifetime_revenue_val,
 impression_qty
FROM smp_production_core.t_dim_campaign_2
WHERE campaign_start_dt >= DATE '2023-01-01'
 AND LOWER(campaign_name) NOT LIKE LOWER('%TEST_2%');