create or replace view SMP_PRODUCTION.FE_PORTAL_SMP.V_CAMPAIGN_AB_TEST_PERIOD_2(
	DIVISION_ID,
	COUNTRY_ID,
	CAMPAIGN_ID,
	CAMPAIGN_NAME,
	ADVERTISER_ID_SMP,
	CAMPAIGN_START_DT,
	CAMPAIGN_END_DT,
	CHANNEL_ID,
	AB_SPLIT_DESCR,
	AB_SPLIT,
	EXPORT_CSV,
	PERIOD,
	INCR_CONVERSION,
	UPLIFT_CONVERSION_PCT,
	UPLIFT_CONVERSION_DESCR,
	CELL_TEST_QTY_SUM,
	CELL_CONTROL_QTY_SUM
) as 
SELECT 
   c.division_id
  ,c.country_id 
  ,c.campaign_id
  ,c.campaign_name
  ,COALESCE(e.ADVERTISER_ID_SMP_SPLIT, c.ADVERTISER_ID_SMP) AS ADVERTISER_ID_SMP_
  ,c.campaign_start_dt
  ,c.campaign_end_dt
  ,COALESCE(cm.channel_id_map, c.channel_id) AS channel_id 
  ,CAST(ROUND(c.test_cell_pct) AS VARCHAR) || ' / ' || CAST(ROUND(c.control_cell_pct) AS VARCHAR) AS ab_split_descr
  ,c.ab_group_normalization_factor AS ab_split
  ,NULL AS export_csv
  ,D.PERIOD 
  ,d.incr_conversion
  ,d.uplift_conversion_pct
  ,CASE WHEN D.uplift_conversion_pct > 0 THEN 'positive lift'
        WHEN D.uplift_conversion_pct < 0 THEN 'negative lift'
        ELSE 'no lift'
   END AS uplift_conversion_descr
  
  ,d.cell_test_qty_sum
  ,d.cell_control_qty_sum
FROM core.t_ab_campaign_setup_2 c

INNER JOIN 
(
  SELECT 
     division_id
    ,country_id 
    ,campaign_id
    ,PERIOD
    ,SUM(test_qty) cell_test_qty_sum    
    ,SUM(control_qty) cell_control_qty_sum
    
    ,cell_test_qty_sum - cell_control_qty_sum AS incr_conversion
    ,DIV0NULL((cell_test_qty_sum - cell_control_qty_sum) , cell_control_qty_sum) -1 AS uplift_conversion_pct
  FROM core.v_ab_test_result_week_2
  GROUP BY 1,2,3,4
) d 
ON c.division_id = D.division_id 
  AND c.country_id = D.country_id 
  AND c.campaign_id = D.campaign_id


LEFT OUTER JOIN etl_process.t_campaign_advertiser_exception_2 e
ON c.division_id = e.division_id
  AND c.country_id = e.country_id
  AND c.campaign_id = e.campaign_id 


LEFT OUTER JOIN etl_process.t_ref_channel_map_2 cm
ON c.division_id = cm.division_id
  AND c.country_id = cm.country_id
  AND c.channel_id = cm.channel_id 


INNER JOIN fe_portal_smp.v_campaign_portal_permission_2 p
ON c.division_id = p.division_id
  AND c.country_id = p.country_id
  AND c.campaign_id = p.campaign_id

WHERE 1=2 
;
