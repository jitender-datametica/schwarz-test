
CREATE OR REPLACE VIEW smp_production_fe_portal_smp.v_campaign_measurement_week (cy_week, campaign_id, advertiser_id,
source_system_id, advertiser_id_smp, advertiser_id_piq, campaign_name, campaign_start_dt, campaign_end_dt, channel_id,
budget_val, attribution_start_dt, attribution_end_dt, gtin_assigned_list, campaign_type_id, campaign_status_id, bid_val
, campaign_id_ext, country_id, division_id, sales_qty, sales_val, bid_avg_val, budget_spent_val, impression_qty,
view_qty, click_qty, shopper_qty, conversion_qty, retail_baseline_pct, retail_halo_pct, view_frequency_pct,
click_through_pct, conversion_pct, roas_pct, campaign_last_modified) AS
-- Workaround weil SMP den Split nicht ueber die SST liefern kannt (SMST-2762)
 SELECT W.cy_week,
 W.campaign_id,
 W.advertiser_id,
 W.source_system_id,
 COALESCE(E.advertiser_id_smp_split, W.advertiser_id_smp) AS advertiser_id_smp_,
 W.advertiser_id_piq,
 W.campaign_name,
 W.campaign_start_dt,
 W.campaign_end_dt,
 COALESCE(CM.channel_id_map, W.channel_id) AS channel_id,
 W.budget_val,
 W.attribution_start_dt,
 W.attribution_end_dt,
 W.gtin_assigned_list,
 W.campaign_type_id,
 W.campaign_status_id,
 W.advertiser_bid_val AS bid_val,
 W.campaign_id_ext,
 W.country_id,
 W.division_id,
 W.sales_qty,
 W.sales_val,
 W.bid_avg_val,
  IFNULL(W.budget_spent_val, 0) + IFNULL(CASE
    WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 0
    THEN NRT.budget_spent_val_1d
    WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 1
    THEN NRT.budget_spent_val_2d
    WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 2
    THEN NRT.budget_spent_val_3d
    ELSE NULL
    END, 0) AS budget_spent_val,
 W.impression_qty,
  IFNULL(W.view_qty, 0) + IFNULL(CASE
    WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 0
    THEN NRT.view_qty_1d
    WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 1
    THEN NRT.view_qty_2d
    WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 2
    THEN NRT.view_qty_3d
    ELSE NULL
    END, 0) AS view_qty,
  IFNULL(W.click_qty, 0) + IFNULL(CASE
    WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 0
    THEN NRT.click_qty_1d
    WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 1
    THEN NRT.click_qty_2d
    WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 2
    THEN NRT.click_qty_3d
    ELSE NULL
    END, 0) AS click_qty,
 W.shopper_qty,
 W.conversion_qty,
 W.retail_baseline_pct,
 W.retail_halo_pct,
 CAST(IF(W.view_qty / IF(W.shopper_qty = 0, NULL, W.shopper_qty) = 0, NULL, W.view_qty / IF(W.shopper_qty = 0, NULL, W.shopper_qty)) AS NUMERIC)
 AS view_frequency_pct,
 CAST(100 * IF((IFNULL(W.click_qty, 0) + IFNULL(CASE
          WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 0
          THEN NRT.click_qty_1d
          WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 1
          THEN NRT.click_qty_2d
          WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 2
          THEN NRT.click_qty_3d
          ELSE NULL
          END, 0)) / IF(IFNULL(W.view_qty, 0) + IFNULL(CASE
           WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 0
           THEN NRT.view_qty_1d
           WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 1
           THEN NRT.view_qty_2d
           WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 2
           THEN NRT.view_qty_3d
           ELSE NULL
           END, 0) = 0, NULL, IFNULL(W.view_qty, 0) + IFNULL(CASE
          WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 0
          THEN NRT.view_qty_1d
          WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 1
          THEN NRT.view_qty_2d
          WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 2
          THEN NRT.view_qty_3d
          ELSE NULL
          END, 0)) = 0, NULL, (IFNULL(W.click_qty, 0) + IFNULL(CASE
         WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 0
         THEN NRT.click_qty_1d
         WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 1
         THEN NRT.click_qty_2d
         WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 2
         THEN NRT.click_qty_3d
         ELSE NULL
         END, 0)) / IF(IFNULL(W.view_qty, 0) + IFNULL(CASE
          WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 0
          THEN NRT.view_qty_1d
          WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 1
          THEN NRT.view_qty_2d
          WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 2
          THEN NRT.view_qty_3d
          ELSE NULL
          END, 0) = 0, NULL, IFNULL(W.view_qty, 0) + IFNULL(CASE
         WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 0
         THEN NRT.view_qty_1d
         WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 1
         THEN NRT.view_qty_2d
         WHEN DATE_DIFF(CURRENT_DATE, DATE(W.upd_tmsp), DAY) = 2
         THEN NRT.view_qty_3d
         ELSE NULL
         END, 0))) AS NUMERIC) AS click_through_pct,
 CAST(IF(W.conversion_qty / IF(W.click_qty = 0, NULL, W.click_qty) = 0, NULL, W.conversion_qty / IF(W.click_qty = 0, NULL, W.click_qty)) AS NUMERIC)
 AS conversion_pct,
 CAST(IF(W.sales_val / IF(W.budget_spent_val = 0, NULL, W.budget_spent_val) = 0, NULL, W.sales_val / IF(W.budget_spent_val = 0, NULL, W.budget_spent_val)) AS NUMERIC)
 AS roas_pct,
 W.campaign_last_modified
FROM smp_production_core.t_fact_campaign_measurement_week AS W
 LEFT JOIN smp_production_etl_process.t_campaign_advertiser_exception AS E ON W.division_id = E.division_id AND W.country_id
     = E.country_id AND W.campaign_id = E.campaign_id -- mapping channel_id nach Vorgabe aus SMST-1795

 LEFT JOIN smp_production_etl_process.t_ref_channel_map AS CM ON W.division_id = CM.division_id AND W.country_id = CM.country_id
     AND W.channel_id = CM.channel_id
 LEFT JOIN smp_production_core.v_nrt_campaign_measurement_week AS NRT ON W.campaign_id = NRT.campaign_id AND W.cy_week =
   NRT.cy_week -- Filter Berechtigung in Abhaengigkeit von Umgebung

 INNER JOIN smp_production_fe_portal_smp.v_campaign_portal_permission AS P ON W.division_id = P.division_id AND W.country_id
     = P.country_id AND W.campaign_id = P.campaign_id;