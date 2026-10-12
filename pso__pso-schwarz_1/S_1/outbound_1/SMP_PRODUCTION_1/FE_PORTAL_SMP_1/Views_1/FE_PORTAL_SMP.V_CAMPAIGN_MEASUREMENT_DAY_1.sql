CREATE OR REPLACE VIEW smp_production_fe_portal_smp.v_campaign_measurement_day_1 (day_dt, campaign_id, advertiser_id,
source_system_id, advertiser_id_smp, advertiser_id_piq, campaign_name, campaign_start_dt, campaign_end_dt, channel_id,
budget_val, attribution_start_dt, attribution_end_dt, gtin_assigned_list, campaign_type_id, campaign_status_id, bid_val
, campaign_id_ext, country_id, division_id, sales_qty, sales_val, bid_avg_val, budget_spent_val, impression_qty,
view_qty, click_qty, shopper_qty, conversion_qty, view_frequency_pct, click_through_pct, conversion_pct, roas_pct,
champaign_last_modified) AS SELECT M.day_dt,
 M.campaign_id,
 M.advertiser_id,
 M.source_system_id,
 COALESCE(E.advertiser_id_smp_split, M.advertiser_id_smp) AS advertiser_id_smp_,
 M.advertiser_id_piq,
 M.campaign_name,
 M.campaign_start_dt,
 M.campaign_end_dt,
 COALESCE(CM.channel_id_map, M.channel_id) AS channel_id,
 M.budget_val,
 M.attribution_start_dt,
 M.attribution_end_dt,
 M.gtin_assigned_list,
 M.campaign_type_id,
 M.campaign_status_id,
 M.advertiser_bid_val AS bid_val,
 M.campaign_id_ext,
 M.country_id,
 M.division_id,
 M.sales_qty,
 M.sales_val,
 M.bid_avg_val,
  CASE
  WHEN M.day_dt >= DATE(M.upd_tmsp)
  THEN NRT.budget_spent_val
  ELSE M.budget_spent_val
  END AS budget_spent_val,
 M.impression_qty,
  CASE
  WHEN M.day_dt >= DATE(M.upd_tmsp)
  THEN NRT.view_qty
  ELSE M.view_qty
  END AS view_qty,
  CASE
  WHEN M.day_dt >= DATE(M.upd_tmsp)
  THEN NRT.click_qty
  ELSE M.click_qty
  END AS click_qty,
 M.shopper_qty,
 M.conversion_qty,
 CAST(IF(M.view_qty / IF(M.shopper_qty = 0, NULL, M.shopper_qty) = 0, NULL, M.view_qty / IF(M.shopper_qty = 0, NULL, M.shopper_qty)) AS NUMERIC)
 AS view_frequency_pct,
  CASE
  WHEN M.day_dt >= DATE(M.upd_tmsp)
  THEN NRT.click_through_pct
  ELSE CAST(100 * IF(M.click_qty / IF(M.view_qty = 0, NULL, M.view_qty) = 0, NULL, M.click_qty / IF(M.view_qty = 0, NULL, M.view_qty)) AS NUMERIC)
  END AS click_through_pct,
 CAST(IF(M.conversion_qty / IF(M.click_qty = 0, NULL, M.click_qty) = 0, NULL, M.conversion_qty / IF(M.click_qty = 0, NULL, M.click_qty)) AS NUMERIC)
 AS conversion_pct,
 CAST(IF(M.sales_val / IF(M.budget_spent_val = 0, NULL, M.budget_spent_val) = 0, NULL, M.sales_val / IF(M.budget_spent_val = 0, NULL, M.budget_spent_val)) AS NUMERIC)
 AS roas_pct,
 M.campaign_last_modified AS champaign_last_modified
FROM smp_production_core.t_fact_campaign_measurement_day_1 AS M
 LEFT JOIN smp_production_etl_process.t_campaign_advertiser_exception_1 AS E ON M.division_id = E.division_id AND M.country_id
     = E.country_id AND M.campaign_id = E.campaign_id
 LEFT JOIN smp_production_etl_process.t_ref_channel_map_1 AS CM ON M.division_id = CM.division_id AND M.country_id = CM.country_id
     AND M.channel_id = CM.channel_id
 LEFT JOIN smp_production_core.v_nrt_campaign_measurement_day_1 AS NRT ON M.campaign_id = NRT.campaign_id AND M.day_dt =
   NRT.day_dt
 INNER JOIN smp_production_fe_portal_smp.v_campaign_portal_permission_1 AS P ON M.division_id = P.division_id AND M.country_id
     = P.country_id AND M.campaign_id = P.campaign_id;