create or replace view SMP_PRODUCTION.FE_MSTR_SMP.V_CAMPAIGN_AB_TEST_GTIN_PERIOD_WEEK(
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
	CY_WEEK,
	GTIN_ID,
	INCR_CONVERSION,
	UPLIFT_CONVERSION_PCT,
	UPLIFT_SALES_PCT,
	UPLIFT_CONVERSION_DESCR,
	CELL_TEST_QTY_SUM,
	CELL_CONTROL_QTY_SUM,
	TEST_QTY,
	TEST_VAL,
	CONTROL_QTY,
	CONTROL_VAL
) as 
SELECT 
   c.division_id
  ,c.country_id 
  ,c.campaign_id
  ,c.campaign_name
  ,c.advertiser_id_smp
  ,c.campaign_start_dt
  ,c.campaign_end_dt
  ,c.channel_id
  ,CAST(ROUND(c.test_cell_pct) AS VARCHAR) || ' / ' || CAST(ROUND(c.control_cell_pct) AS VARCHAR) AS ab_split_descr
  ,c.ab_group_normalization_factor AS ab_split
  ,NULL AS export_csv
  ,D.PERIOD 
  ,D.cy_week
  ,D.gtin_id
  -- kpi
  ,d.incr_conversion
  ,d.uplift_conversion_pct
  ,c.uplift_sales_pct
  ,CASE WHEN D.uplift_conversion_pct > 0 THEN 'positive lift'
        WHEN D.uplift_conversion_pct < 0 THEN 'negative lift'
        ELSE 'no lift'
   END AS uplift_conversion_descr
  -- Details
  ,d.cell_test_qty_sum    
  ,d.cell_control_qty_sum
  ,d.TEST_QTY_SUM AS TEST_QTY
  ,d.TEST_VAL_SUM AS TEST_VAL
  ,d.CONTROL_QTY_SUM AS CONTROL_QTY
  ,d.CONTROL_VAL_SUM AS CONTROL_VAL
FROM core.t_ab_campaign_setup c

FULL OUTER JOIN 
(
  SELECT 
     division_id
    ,country_id 
    ,campaign_id
    ,PERIOD
    ,cy_week
    ,gtin_id 
    ,SUM(test_qty) cell_test_qty_sum    
    ,SUM(control_qty) cell_control_qty_sum
    ,sum(TEST_QTY) TEST_QTY_SUM
    ,sum(TEST_VAL) TEST_VAL_SUM
    ,sum(CONTROL_QTY) CONTROL_QTY_SUM
    ,sum(CONTROL_VAL) CONTROL_VAL_SUM
    -- kpi
    ,cell_test_qty_sum - cell_control_qty_sum AS incr_conversion
    ,DIV0NULL((cell_test_qty_sum - cell_control_qty_sum) , cell_control_qty_sum) -1 AS uplift_conversion_pct
  FROM core.t_ab_test_result
  GROUP BY 1,2,3,4,5,6
) d 
ON c.division_id = D.division_id 
  AND c.country_id = D.country_id 
  AND c.campaign_id = D.campaign_id;
