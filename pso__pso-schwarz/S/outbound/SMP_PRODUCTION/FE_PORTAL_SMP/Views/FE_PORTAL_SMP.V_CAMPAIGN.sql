CREATE OR REPLACE VIEW smp_production_fe_portal_smp.v_campaign (campaign_id, advertiser_id, source_system_id,
advertiser_id_smp, advertiser_id_piq, campaign_name, campaign_start_dt, campaign_end_dt, channel_id, budget_val,
attribution_start_dt, attribution_end_dt, gtin_assigned_list, campaign_type_id, campaign_status_id, bid_val,
campaign_id_ext, country_id, division_id, sales_qty, sales_val, bid_avg_val, budget_spent_val, impression_qty, view_qty
, click_qty, shopper_qty, conversion_qty, ntp_pct, lifetime_revenue_val, view_frequency_pct, click_through_pct,
conversion_pct, roas_pct, campaign_last_modified, new_to_brand_pct) AS SELECT C.campaign_id,
 C.advertiser_id,
 C.source_system_id,
 COALESCE(E.advertiser_id_smp_split, C.advertiser_id_smp) AS advertiser_id_smp_,
 C.advertiser_id_piq,
 C.campaign_name,
 C.campaign_start_dt,
 C.campaign_end_dt,
 COALESCE(CM.channel_id_map, C.channel_id) AS channel_id,
 C.budget_val,
 C.attribution_start_dt,
 C.attribution_end_dt,
 C.gtin_assigned_list,
 C.campaign_type_id,
 C.campaign_status_id,
 C.advertiser_bid_val AS bid_val,
 C.campaign_id_ext,
 C.country_id,
 C.division_id,
 C.sales_qty,
 C.sales_val,
 C.bid_avg_val,
  IFNULL(C.budget_spent_val, 0) + IFNULL(CASE
    WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 0
    THEN NRT.budget_spent_val_1d
    WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 1
    THEN NRT.budget_spent_val_2d
    WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 2
    THEN NRT.budget_spent_val_3d
    ELSE NULL
    END, 0) AS budget_spent_val,
 C.impression_qty,
  IFNULL(C.view_qty, 0) + IFNULL(CASE
    WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 0
    THEN NRT.view_qty_1d
    WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 1
    THEN NRT.view_qty_2d
    WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 2
    THEN NRT.view_qty_3d
    ELSE NULL
    END, 0) AS view_qty,
  IFNULL(C.click_qty, 0) + IFNULL(CASE
    WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 0
    THEN NRT.click_qty_1d
    WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 1
    THEN NRT.click_qty_2d
    WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 2
    THEN NRT.click_qty_3d
    ELSE NULL
    END, 0) AS click_qty,
 C.shopper_qty,
 C.conversion_qty,
 C.ntp_shopper_pct AS ntp_pct,
 C.lifetime_revenue_val,
 CAST(IF(C.view_qty / IF(C.shopper_qty = 0, NULL, C.shopper_qty) = 0, NULL, C.view_qty / IF(C.shopper_qty = 0, NULL, C.shopper_qty)) AS NUMERIC)
 AS view_frequency_pct,
 CAST(100 * IF((IFNULL(C.click_qty, 0) + IFNULL(CASE
          WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 0
          THEN NRT.click_qty_1d
          WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 1
          THEN NRT.click_qty_2d
          WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 2
          THEN NRT.click_qty_3d
          ELSE NULL
          END, 0)) / IF(IFNULL(C.view_qty, 0) + IFNULL(CASE
           WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 0
           THEN NRT.view_qty_1d
           WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 1
           THEN NRT.view_qty_2d
           WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 2
           THEN NRT.view_qty_3d
           ELSE NULL
           END, 0) = 0, NULL, IFNULL(C.view_qty, 0) + IFNULL(CASE
          WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 0
          THEN NRT.view_qty_1d
          WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 1
          THEN NRT.view_qty_2d
          WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 2
          THEN NRT.view_qty_3d
          ELSE NULL
          END, 0)) = 0, NULL, (IFNULL(C.click_qty, 0) + IFNULL(CASE
         WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 0
         THEN NRT.click_qty_1d
         WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 1
         THEN NRT.click_qty_2d
         WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 2
         THEN NRT.click_qty_3d
         ELSE NULL
         END, 0)) / IF(IFNULL(C.view_qty, 0) + IFNULL(CASE
          WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 0
          THEN NRT.view_qty_1d
          WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 1
          THEN NRT.view_qty_2d
          WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 2
          THEN NRT.view_qty_3d
          ELSE NULL
          END, 0) = 0, NULL, IFNULL(C.view_qty, 0) + IFNULL(CASE
         WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 0
         THEN NRT.view_qty_1d
         WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 1
         THEN NRT.view_qty_2d
         WHEN DATE_DIFF(CURRENT_DATE, DATE(C.upd_tmsp), DAY) = 2
         THEN NRT.view_qty_3d
         ELSE NULL
         END, 0))) AS NUMERIC) AS click_through_pct,
 CAST(IF(C.conversion_qty / IF(C.click_qty = 0, NULL, C.click_qty) = 0, NULL, C.conversion_qty / IF(C.click_qty = 0, NULL, C.click_qty)) AS NUMERIC)
 AS conversion_pct,
 CAST(IF(C.sales_val / IF(C.budget_spent_val = 0, NULL, C.budget_spent_val) = 0, NULL, C.sales_val / IF(C.budget_spent_val = 0, NULL, C.budget_spent_val)) AS NUMERIC)
 AS roas_pct,
 C.campaign_last_modified,
 C.ntp_shopper_pct AS new_to_brand_pct
FROM smp_production_core.t_dim_campaign AS C
 LEFT JOIN smp_production_etl_process.t_campaign_advertiser_exception AS E ON C.division_id = E.division_id AND C.country_id
     = E.country_id AND C.campaign_id = E.campaign_id
 LEFT JOIN smp_production_etl_process.t_ref_channel_map AS CM ON C.division_id = CM.division_id AND C.country_id = CM.country_id
     AND C.channel_id = CM.channel_id
 LEFT JOIN smp_production_core.v_nrt_campaign AS NRT ON C.campaign_id = NRT.campaign_id
 INNER JOIN smp_production_fe_portal_smp.v_campaign_portal_permission AS P ON C.division_id = P.division_id AND C.country_id
     = P.country_id AND C.campaign_id = P.campaign_id;