CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dim_campaign_2 (country_id, division_id, campaign_id, advertiser_id,
source_system_id, advertiser_id_smp, advertiser_id_piq, campaign_name, campaign_start_dt, campaign_end_dt,
duration_in_days, campaign_status_id, channel_id, attribution_start_dt, attribution_end_dt, gtin_assigned_list,
campaign_type_id, campaign_id_ext, supplier_id_ref, food_fg, advertiser_bid_val, sales_qty, sales_val, bid_avg_val,
budget_val, budget_spent_val, impression_qty, view_qty, click_qty, shopper_qty, conversion_qty, purchase_frequency,
repurchase_rate_pct, lifetime_revenue_val, campaign_last_modified, status_2, cnt_campaigns_within_group,
cnt_active_campaigns_within_group, status_total) AS SELECT DISTINCT RC.country_id,
 RC.division_id,
 RC.campaign_id,
 RC.advertiser_id,
 RC.source_system_id,
 RC.advertiser_id_smp,
 RC.advertiser_id_piq,
 RC.campaign_name,
 RC.campaign_start_dt,
 RC.campaign_end_dt,
 DATE_DIFF(RC.campaign_end_dt, RC.campaign_start_dt, DAY) AS duration_in_days,
 RC.campaign_status_id,
 RC.channel_id,
 RC.attribution_start_dt,
 RC.attribution_end_dt,
 RC.gtin_assigned_list,
 RC.campaign_type_id,
 RC.campaign_id_ext,
 RC.supplier_id_ref,
 RC.food_fg,
 RC.advertiser_bid_val,
 RC.sales_qty,
 RC.sales_val,
 RC.bid_avg_val,
 RC.budget_val,
 RC.budget_spent_val,
 RC.impression_qty,
 RC.view_qty,
 RC.click_qty,
 RC.shopper_qty,
 RC.conversion_qty,
 RC.purchase_frequency,
 RC.repurchase_rate_pct,
 RC.lifetime_revenue_val,
 RC.campaign_last_modified,
  CASE
  WHEN CURRENT_DATE BETWEEN RC.campaign_start_dt AND RC.campaign_end_dt
  THEN 'RUNNING'
  WHEN CURRENT_DATE > RC.campaign_end_dt
  THEN 'ENDED'
  WHEN CURRENT_DATE < RC.campaign_start_dt
  THEN 'NOT STARTED YET'
  ELSE NULL
  END AS status_2,
 COUNT(REL.campaign_id) OVER (PARTITION BY REL.campaign_group_id RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS cnt_campaigns_within_group,
 SUM(CASE
   WHEN CASE
     WHEN CURRENT_DATE BETWEEN RC.campaign_start_dt AND RC.campaign_end_dt
     THEN 'RUNNING'
     WHEN CURRENT_DATE > RC.campaign_end_dt
     THEN 'ENDED'
     WHEN CURRENT_DATE < RC.campaign_start_dt
     THEN 'NOT STARTED YET'
     ELSE NULL
     END = 'RUNNING'
   THEN 1
   ELSE 0
   END) OVER (PARTITION BY REL.campaign_group_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
 cnt_active_campaigns_within_group,
 CONCAT(CASE
   WHEN CURRENT_DATE BETWEEN RC.campaign_start_dt AND RC.campaign_end_dt
   THEN 'RUNNING'
   WHEN CURRENT_DATE > RC.campaign_end_dt
   THEN 'ENDED'
   WHEN CURRENT_DATE < RC.campaign_start_dt
   THEN 'NOT STARTED YET'
   ELSE NULL
   END, '/', COUNT(REL.campaign_id) OVER (PARTITION BY REL.campaign_group_id RANGE BETWEEN UNBOUNDED PRECEDING AND
   UNBOUNDED FOLLOWING), ' CAMPAIGN(S) WITHIN GROUP, ', SUM(CASE
    WHEN CASE
      WHEN CURRENT_DATE BETWEEN RC.campaign_start_dt AND RC.campaign_end_dt
      THEN 'RUNNING'
      WHEN CURRENT_DATE > RC.campaign_end_dt
      THEN 'ENDED'
      WHEN CURRENT_DATE < RC.campaign_start_dt
      THEN 'NOT STARTED YET'
      ELSE NULL
      END = 'RUNNING'
    THEN 1
    ELSE 0
    END) OVER (PARTITION BY REL.campaign_group_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), ' RUNNING'
  ) AS status_total
FROM smp_production_core.t_dim_campaign_2 AS RC
 LEFT JOIN smp_production_fe_mstr_smp.v_campaign_group_rel_2 AS REL ON RC.campaign_id = REL.campaign_id AND RC.country_id
    = REL.country_id AND RC.division_id = REL.division_id
 LEFT JOIN smp_production_core_rel.t_campaign_group_2 AS RG ON REL.campaign_group_id = RG.campaign_group_id AND REL.country_id
     = RG.country_id AND REL.division_id = RG.division_id;