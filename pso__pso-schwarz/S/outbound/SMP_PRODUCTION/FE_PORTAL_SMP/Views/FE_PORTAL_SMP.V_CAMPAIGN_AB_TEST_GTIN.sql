CREATE OR REPLACE VIEW smp_production_fe_portal_smp.v_campaign_ab_test_gtin (division_id, country_id, campaign_id,
campaign_name, advertiser_id_smp, campaign_start_dt, campaign_end_dt, channel_id, ab_split_descr, ab_split, export_csv,
gtin_id, incr_conversion, uplift_conversion_pct, uplift_conversion_descr, uplift_sales_pct, uplift_sales_descr,
cell_test_qty_sum, cell_control_qty_sum, conversion_period_test_cell_test, conversion_period_pre_cell_test) AS SELECT C
 .division_id,
 C.country_id,
 C.campaign_id,
 C.campaign_name,
 COALESCE(E.advertiser_id_smp_split, C.advertiser_id_smp) AS advertiser_id_smp_,
 C.campaign_start_dt,
 C.campaign_end_dt,
 COALESCE(CM.channel_id_map, C.channel_id) AS channel_id,
   CAST(ROUND(C.test_cell_pct) AS STRING) || ' / ' || CAST(ROUND(C.control_cell_pct) AS STRING) AS ab_split_descr,
 C.ab_group_normalization_factor AS ab_split,
 NULL AS export_csv,
 d.gtin_id,
 d.incr_conversion,
 d.uplift_conversion_pct,
  CASE
  WHEN d.uplift_conversion_pct > 0
  THEN 'positive lift'
  WHEN d.uplift_conversion_pct < 0
  THEN 'negative lift'
  ELSE 'no lift'
  END AS uplift_conversion_descr,
 d.uplift_sales_pct,
  CASE
  WHEN d.uplift_sales_pct > 0
  THEN 'positive lift'
  WHEN d.uplift_sales_pct < 0
  THEN 'negative lift'
  ELSE 'no lift'
  END AS uplift_sales_descr,
 d.cell_test_qty_sum,
 d.cell_control_qty_sum,
 d.conversion_period_test_cell_test,
 d.conversion_period_pre_cell_test
FROM smp_production_core.t_ab_campaign_setup AS C
 INNER JOIN (SELECT division_id,
   country_id,
   campaign_id,
   gtin_id,
   SUM(test_qty) AS cell_test_qty_sum,
   SUM(control_qty) AS cell_control_qty_sum,
   SUM(CASE
     WHEN period = 'TEST'
     THEN test_qty
     ELSE 0
     END) AS conversion_period_test_cell_test,
   SUM(CASE
     WHEN period = 'PRE'
     THEN test_qty
     ELSE 0
     END) AS conversion_period_pre_cell_test,
    SUM(test_qty) - SUM(control_qty) AS incr_conversion,
    IF(SUM(control_qty) = 0 OR SUM(control_qty) IS NULL, 0, SAFE_DIVIDE(SUM(test_qty) - SUM(control_qty), SUM(control_qty
       ))) - 1 AS uplift_conversion_pct,
    IF(SUM(CASE
         WHEN period = 'PRE'
         THEN test_qty
         ELSE 0
         END) = 0 OR SUM(CASE
        WHEN period = 'PRE'
        THEN test_qty
        ELSE 0
        END) IS NULL, 0, SAFE_DIVIDE(SUM(CASE
         WHEN period = 'TEST'
         THEN test_qty
         ELSE 0
         END) - SUM(CASE
         WHEN period = 'PRE'
         THEN test_qty
         ELSE 0
         END), SUM(CASE
        WHEN period = 'PRE'
        THEN test_qty
        ELSE 0
        END))) - 1 AS uplift_sales_pct
  FROM smp_production_core.v_ab_test_result_week
  GROUP BY division_id,
   country_id,
   campaign_id,
   gtin_id) AS d ON C.division_id = d.division_id AND C.country_id = d.country_id AND C.campaign_id = d.campaign_id
 LEFT JOIN smp_production_etl_process.t_campaign_advertiser_exception AS E ON C.division_id = E.division_id AND C.country_id
     = E.country_id AND C.campaign_id = E.campaign_id
 LEFT JOIN smp_production_etl_process.t_ref_channel_map AS CM ON C.division_id = CM.division_id AND C.country_id = CM.country_id
     AND C.channel_id = CM.channel_id
 INNER JOIN smp_production_fe_portal_smp.v_campaign_portal_permission AS P ON C.division_id = P.division_id AND C.country_id
     = P.country_id AND C.campaign_id = P.campaign_id
WHERE 1 = 2;