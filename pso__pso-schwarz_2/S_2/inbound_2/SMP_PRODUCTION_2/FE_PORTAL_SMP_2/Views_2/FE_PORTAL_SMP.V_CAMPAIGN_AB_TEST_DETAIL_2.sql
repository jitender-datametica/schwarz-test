create or replace view SMP_PRODUCTION.FE_PORTAL_SMP.V_CAMPAIGN_AB_TEST_DETAIL_2(
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
	PERIOD,
	CY_WEEK,
	GTIN_ID,
	CONTROL_QTY,
	TEST_QTY,
	CONTROL_VAL,
	TEST_VAL,
	CONTROL_QTY_ATTRIB_SALES,
	TEST_QTY_ATTRIB_SALES,
	CONTROL_VAL_ATTRIB_SALES,
	TEST_VAL_ATTRIB_SALES,
	INCR_CONVERSION,
	UPLIFT_CONVERSION_PCT,
	UPLIFT_CONVERSION_DESCR
) as 
SELECT 
   d.division_id
  ,d.country_id 
  ,d.campaign_id
  ,d.campaign_name
  ,COALESCE(e.ADVERTISER_ID_SMP_SPLIT, c.ADVERTISER_ID_SMP) AS ADVERTISER_ID_SMP_
  ,c.campaign_start_dt
  ,c.campaign_end_dt
  ,COALESCE(cm.channel_id_map, c.channel_id) AS channel_id 
  ,CAST(ROUND(c.test_cell_pct) AS VARCHAR) || ' / ' || CAST(ROUND(c.control_cell_pct) AS VARCHAR) AS ab_split_descr
  ,c.ab_group_normalization_factor AS ab_split
  ,d.PERIOD
  ,d.cy_week
  ,d.gtin_id 
  ,d.control_qty
  ,d.test_qty
  ,d.control_val
  ,d.test_val
  ,d.control_qty_attrib_sales
  ,d.test_qty_attrib_sales
  ,d.control_val_attrib_sales
  ,d.test_val_attrib_sales
  ,d.test_qty - d.control_qty AS incr_conversion
  ,DIV0NULL((d.test_qty-d.control_qty) , d.control_qty) -1 uplift_conversion_pct
  ,CASE WHEN uplift_conversion_pct > 0 THEN 'positive lift'
        WHEN uplift_conversion_pct < 0 THEN 'negative lift'
        ELSE 'no lift'
   END AS uplift_conversion_descr
FROM core.v_ab_test_result_week_2 D

INNER JOIN core.t_ab_campaign_setup_2 c
ON D.division_id = c.division_id
  AND D.country_id = c.country_id 
  AND D.campaign_id = c.campaign_id


LEFT OUTER JOIN etl_process.t_campaign_advertiser_exception_2 e
ON c.division_id = e.division_id
  AND c.country_id = e.country_id
  AND c.campaign_id = e.campaign_id 


LEFT OUTER JOIN etl_process.t_ref_channel_map_2 cm
ON c.division_id = cm.division_id
  AND c.country_id = cm.country_id
  AND c.channel_id = cm.channel_id


INNER JOIN fe_portal_smp.v_campaign_portal_permission_2 p
ON D.division_id = p.division_id
  AND D.country_id = p.country_id 
  AND D.campaign_id = p.campaign_id

WHERE 1=2 
;
