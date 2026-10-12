create or replace view SMP_PRODUCTION.FE_PORTAL_SMP.V_CAMPAIGN_AB_TEST_1(
	DIVISION_ID,
	COUNTRY_ID,
	CAMPAIGN_ID,
	CAMPAIGN_NAME,
	CAMPAIGN_TYPE_ID,
	ADVERTISER_ID_SMP,
	CAMPAIGN_START_DT,
	CAMPAIGN_END_DT,
	CHANNEL_ID,
	AB_SPLIT_DESCR,
	AB_SPLIT,
	EXPORT_CSV,
	INCR_CONVERSION,
	UPLIFT_CONVERSION_PCT,
	UPLIFT_CONVERSION_DESCR,
	UPLIFT_SALES_PCT,
	UPLIFT_SALES_DESCR,
	IROAS_PCT,
	UPLIFT_NTP_PCT,
	UPLIFT_NTP_DESCR,
	CELL_TEST_QTY_SUM,
	CELL_CONTROL_QTY_SUM,
	CONVERSION_PERIOD_TEST_CELL_TEST,
	CONVERSION_PERIOD_PRE_CELL_TEST,
	TEST_CELL_NTP_PCT,
	CONTROL_CELL_NTP_PCT
) as 
SELECT 
   c.division_id
  ,c.country_id 
  ,c.campaign_id 
  ,c.campaign_name
  ,s.campaign_type_id
  ,COALESCE(e.ADVERTISER_ID_SMP_SPLIT, c.ADVERTISER_ID_SMP) AS ADVERTISER_ID_SMP_
  ,c.campaign_start_dt
  ,c.campaign_end_dt
  ,COALESCE(cm.channel_id_map, c.channel_id) AS channel_id 
  ,CAST(ROUND(c.test_cell_pct) AS VARCHAR) || ' / ' || CAST(ROUND(c.control_cell_pct) AS VARCHAR) AS ab_split_descr
  ,c.ab_group_normalization_factor AS ab_split
  ,NULL AS export_csv
  ,c.incr_conversion
  ,c.uplift_conversion_pct
  ,CASE WHEN c.uplift_conversion_pct > 0 THEN 'positive lift'
        WHEN c.uplift_conversion_pct < 0 THEN 'negative lift'
        ELSE 'no lift'
   END AS uplift_conversion_descr 
  ,c.uplift_sales_pct 
  ,CASE WHEN c.uplift_sales_pct > 0 THEN 'positive lift'
        WHEN c.uplift_sales_pct < 0 THEN 'negative lift'
        ELSE 'no lift'
   END AS uplift_sales_descr
  ,c.iroas_pct
	,c.uplift_ntp_pct 
  ,CASE WHEN c.uplift_ntp_pct > 0 THEN 'positive lift'
        WHEN c.uplift_ntp_pct < 0 THEN 'negative lift'
        ELSE 'no lift'
   END AS uplift_ntp_descr
  
  ,d.cell_test_qty_sum
  ,d.cell_control_qty_sum
  ,d.conversion_period_test_cell_test
  ,d.conversion_period_pre_cell_test
  ,c.test_cell_ntp_pct
  ,c.control_cell_ntp_pct
FROM core.t_ab_campaign_setup_1 c

INNER JOIN 
(
  SELECT 
     division_id
    ,country_id 
    ,campaign_id
    ,SUM(test_qty) cell_test_qty_sum    
    ,SUM(control_qty) cell_control_qty_sum
    ,SUM(CASE WHEN PERIOD = 'TEST_1' THEN test_qty ELSE 0 END) AS conversion_period_test_cell_test
    ,SUM(CASE WHEN PERIOD = 'PRE' THEN test_qty ELSE 0 END) AS conversion_period_pre_cell_test
    
    
    
    
  FROM core.v_ab_test_result_week_1
  GROUP BY 1,2,3
) d 
ON c.division_id = D.division_id 
  AND c.country_id = D.country_id 
  AND c.campaign_id = D.campaign_id


INNER JOIN core_rel.t_campaign_1 s
ON c.division_id = s.division_id
  AND c.country_id = s.country_id
  AND c.campaign_id = s.campaign_id 


LEFT OUTER JOIN etl_process.t_campaign_advertiser_exception_1 e
ON c.division_id = e.division_id
  AND c.country_id = e.country_id
  AND c.campaign_id = e.campaign_id 


LEFT OUTER JOIN etl_process.t_ref_channel_map_1 cm
ON c.division_id = cm.division_id
  AND c.country_id = cm.country_id
  AND c.channel_id = cm.channel_id 


INNER JOIN fe_portal_smp.v_campaign_portal_permission_1 p
ON c.division_id = p.division_id
  AND c.country_id = p.country_id
  AND c.campaign_id = p.campaign_id

WHERE 1=2 
;
