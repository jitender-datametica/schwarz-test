CREATE OR REPLACE VIEW smp_production_fe_portal_smp.v_campaign_ab_test_detail_2 (division_id, country_id, campaign_id,
campaign_name, advertiser_id_smp, campaign_start_dt, campaign_end_dt, channel_id, ab_split_descr, ab_split, period,
cy_week, gtin_id, control_qty, test_qty, control_val, test_val, control_qty_attrib_sales, test_qty_attrib_sales,
control_val_attrib_sales, test_val_attrib_sales, incr_conversion, uplift_conversion_pct, uplift_conversion_descr) AS
SELECT D.division_id,
 D.country_id,
 D.campaign_id,
 D.campaign_name,
 COALESCE(E.advertiser_id_smp_split, C.advertiser_id_smp) AS advertiser_id_smp_,
 C.campaign_start_dt,
 C.campaign_end_dt,
 COALESCE(CM.channel_id_map, C.channel_id) AS channel_id,
   CAST(ROUND(C.test_cell_pct) AS STRING) || ' / ' || CAST(ROUND(C.control_cell_pct) AS STRING) AS ab_split_descr,
 C.ab_group_normalization_factor AS ab_split,
 D.period,
 D.cy_week,
 D.gtin_id,
 D.control_qty,
 D.test_qty,
 D.control_val,
 D.test_val,
 D.control_qty_attrib_sales,
 D.test_qty_attrib_sales,
 D.control_val_attrib_sales,
 D.test_val_attrib_sales,
  D.test_qty - D.control_qty AS incr_conversion,
  IF(D.control_qty = 0 OR D.control_qty IS NULL, 0, SAFE_DIVIDE(D.test_qty - D.control_qty, D.control_qty)) - 1 AS
 uplift_conversion_pct,
  CASE
  WHEN C.uplift_conversion_pct > 0
  THEN 'positive lift'
  WHEN C.uplift_conversion_pct < 0
  THEN 'negative lift'
  ELSE 'no lift'
  END AS uplift_conversion_descr
FROM smp_production_core.v_ab_test_result_week_2 AS D
 INNER JOIN smp_production_core.t_ab_campaign_setup_2 AS C ON D.division_id = C.division_id AND D.country_id = C.country_id
     AND D.campaign_id = C.campaign_id
 LEFT JOIN smp_production_etl_process.t_campaign_advertiser_exception_2 AS E ON C.division_id = E.division_id AND C.country_id
     = E.country_id AND C.campaign_id = E.campaign_id
 LEFT JOIN smp_production_etl_process.t_ref_channel_map_2 AS CM ON C.division_id = CM.division_id AND C.country_id = CM.country_id
     AND C.channel_id = CM.channel_id
 INNER JOIN smp_production_fe_portal_smp.v_campaign_portal_permission_2 AS P ON D.division_id = P.division_id AND D.country_id
     = P.country_id AND D.campaign_id = P.campaign_id
WHERE 1 = 2;