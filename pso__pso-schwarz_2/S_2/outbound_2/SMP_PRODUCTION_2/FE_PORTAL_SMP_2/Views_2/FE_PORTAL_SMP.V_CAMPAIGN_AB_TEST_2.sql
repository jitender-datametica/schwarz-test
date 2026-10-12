CREATE OR REPLACE VIEW smp_production_fe_portal_smp.v_campaign_ab_test_2 (division_id, country_id, campaign_id,
campaign_name, campaign_type_id, advertiser_id_smp, campaign_start_dt, campaign_end_dt, channel_id, ab_split_descr,
ab_split, export_csv, incr_conversion, uplift_conversion_pct, uplift_conversion_descr, uplift_sales_pct,
uplift_sales_descr, iroas_pct, uplift_ntp_pct, uplift_ntp_descr, cell_test_qty_sum, cell_control_qty_sum,
conversion_period_test_cell_test, conversion_period_pre_cell_test, test_cell_ntp_pct, control_cell_ntp_pct) AS SELECT C
 .division_id,
 C.country_id,
 C.campaign_id,
 C.campaign_name,
 S.campaign_type_id,
 COALESCE(E.advertiser_id_smp_split, C.advertiser_id_smp) AS advertiser_id_smp_,
 C.campaign_start_dt,
 C.campaign_end_dt,
 COALESCE(CM.channel_id_map, C.channel_id) AS channel_id,
   CAST(ROUND(C.test_cell_pct) AS STRING) || ' / ' || CAST(ROUND(C.control_cell_pct) AS STRING) AS ab_split_descr,
 C.ab_group_normalization_factor AS ab_split,
 NULL AS export_csv,
 C.incr_conversion,
 C.uplift_conversion_pct,
  CASE
  WHEN C.uplift_conversion_pct > 0
  THEN 'positive lift'
  WHEN C.uplift_conversion_pct < 0
  THEN 'negative lift'
  ELSE 'no lift'
  END AS uplift_conversion_descr,
 C.uplift_sales_pct,
  CASE
  WHEN C.uplift_sales_pct > 0
  THEN 'positive lift'
  WHEN C.uplift_sales_pct < 0
  THEN 'negative lift'
  ELSE 'no lift'
  END AS uplift_sales_descr,
 C.iroas_pct,
 C.uplift_ntp_pct,
  CASE
  WHEN C.uplift_ntp_pct > 0
  THEN 'positive lift'
  WHEN C.uplift_ntp_pct < 0
  THEN 'negative lift'
  ELSE 'no lift'
  END AS uplift_ntp_descr,
 d.cell_test_qty_sum,
 d.cell_control_qty_sum,
 d.conversion_period_test_cell_test,
 d.conversion_period_pre_cell_test,
 C.test_cell_ntp_pct,
 C.control_cell_ntp_pct
FROM smp_production_core.t_ab_campaign_setup_2 AS C
 INNER JOIN (SELECT division_id,
   country_id,
   campaign_id,
   SUM(test_qty) AS cell_test_qty_sum,
   SUM(control_qty) AS cell_control_qty_sum,
   SUM(CASE
     WHEN period = 'TEST_2'
     THEN test_qty
     ELSE 0
     END) AS conversion_period_test_cell_test,
   SUM(CASE
     WHEN period = 'PRE'
     THEN test_qty
     ELSE 0
     END) AS conversion_period_pre_cell_test
  FROM smp_production_core.v_ab_test_result_week_2
  GROUP BY division_id,
   country_id,
   campaign_id) AS d ON C.division_id = d.division_id AND C.country_id = d.country_id AND C.campaign_id = d.campaign_id
 INNER JOIN smp_production_core_rel.t_campaign_2 AS S ON C.division_id = S.division_id AND C.country_id = S.country_id AND
   C.campaign_id = S.campaign_id
 LEFT JOIN smp_production_etl_process.t_campaign_advertiser_exception_2 AS E ON C.division_id = E.division_id AND C.country_id
     = E.country_id AND C.campaign_id = E.campaign_id
 LEFT JOIN smp_production_etl_process.t_ref_channel_map_2 AS CM ON C.division_id = CM.division_id AND C.country_id = CM.country_id
     AND C.channel_id = CM.channel_id
 INNER JOIN smp_production_fe_portal_smp.v_campaign_portal_permission_2 AS P ON C.division_id = P.division_id AND C.country_id
     = P.country_id AND C.campaign_id = P.campaign_id
WHERE 1 = 2;
