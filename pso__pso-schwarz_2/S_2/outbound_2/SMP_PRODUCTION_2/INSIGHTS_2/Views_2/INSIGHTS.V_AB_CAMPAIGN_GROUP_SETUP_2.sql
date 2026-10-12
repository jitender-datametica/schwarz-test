CREATE OR REPLACE VIEW smp_production_insights.v_ab_campaign_group_setup_2 (division_id, country_id, campaign_group_id,
campaign_id, campaign_name, campaign_group_start_dt, campaign_group_end_dt, cg_attribution_start_dt,
cg_attribution_end_dt, cg_pre_end_dt, cg_pre_start_dt, cg_ntp_end_dt, cg_ntp_start_dt, budget_spent_val,
ab_campaign_type_id, test_group_cnt, control_group_cnt, test_store_cnt, control_store_cnt, universe_id, universe_name,
division_country_ref, pg_fg, campaign_anz, supplier_id_ref, bid_val, budget_planned_val, ab_universe_split,
units_purchased_attributed_qty, revenue_attributed_val, revenue_attributed_regular_price_val, pexa_audience_id,
pexa_audience_type, pexa_audience_category, pexa_audience_name, campaign_type, campaign_date_start, campaign_date_end,
attribution_date_start, attribution_date_end, budget) AS SELECT S.division_id,
 S.country_id,
 S.campaign_group_id,
 S.campaign_id,
 S.campaign_name,
 S.campaign_group_start_dt,
 S.campaign_group_end_dt,
 S.cg_attribution_start_dt,
 S.cg_attribution_end_dt,
 S.cg_pre_end_dt,
 S.cg_pre_start_dt,
 S.cg_ntp_end_dt,
 S.cg_ntp_start_dt,
 S.budget_spent_val,
 S.ab_campaign_type_id,
 S.test_group_cnt,
 S.control_group_cnt,
 S.test_store_cnt,
 S.control_store_cnt,
 S.universe_id,
 S.universe_name,
 S.division_country_ref,
 S.pg_fg,
 S.campaign_anz,
 S.supplier_id_ref,
 S.bid_val,
 S.budget_planned_val,
 S.ab_universe_split,
 S.units_purchased_attributed_qty,
 S.revenue_attributed_val,
 S.revenue_attributed_regular_price_val -- Extension SMAR-1082
,
  CASE
  WHEN S.ab_campaign_type_id = 'PEXA'
  THEN U.universe_id_opt
  ELSE NULL
  END AS pexa_audience_id,
  CASE
  WHEN S.ab_campaign_type_id = 'PEXA'
  THEN U.universe_type_id
  ELSE NULL
  END AS pexa_audience_type,
  CASE
  WHEN S.ab_campaign_type_id = 'PEXA'
  THEN U.universe_category
  ELSE NULL
  END AS pexa_audience_category,
  CASE
  WHEN S.ab_campaign_type_id = 'PEXA'
  THEN U.universe_name
  ELSE NULL
  END AS pexa_audience_name,
 S.ab_campaign_type_id AS campaign_type,
 S.campaign_group_start_dt AS campaign_date_start,
 S.campaign_group_end_dt AS campaign_date_end,
 S.cg_attribution_start_dt AS attribution_date_start,
 S.cg_attribution_end_dt AS attribution_date_end,
 S.budget_planned_val AS budget
FROM smp_production_insights.t_ab_campaign_group_setup_2 AS S
 INNER JOIN smp_production_core_rel.t_campaign_2 AS C ON S.division_id = C.division_id AND S.country_id = C.country_id AND
   S.campaign_id = C.campaign_id -- DOOH hat keine Audience

 LEFT JOIN smp_production_core_rel.t_universe_2 AS U ON C.division_id = U.division_id AND C.country_id = U.country_id AND
   C.universe_id = U.universe_id;