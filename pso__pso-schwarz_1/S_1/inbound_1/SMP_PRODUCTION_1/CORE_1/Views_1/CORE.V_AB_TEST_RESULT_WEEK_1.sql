create or replace view SMP_PRODUCTION.CORE.V_AB_TEST_RESULT_WEEK_1(
	DIVISION_ID,
	COUNTRY_ID,
	CAMPAIGN_ID,
	CAMPAIGN_NAME,
	CAMPAIGN_TYPE_ID,
	SHOPPER_ID,
	PERIOD,
	CY_WEEK,
	GTIN_ID,
	CAMPAIGN_FG,
	ART_HIERARCHY_LEVEL_ID,
	CONTROL_QTY,
	TEST_QTY,
	CONTROL_VAL,
	TEST_VAL,
	CONTROL_QTY_ATTRIB_SALES,
	TEST_QTY_ATTRIB_SALES,
	CONTROL_VAL_ATTRIB_SALES,
	TEST_VAL_ATTRIB_SALES
) as 
SELECT 
   division_id
  ,country_id
  ,campaign_id
  ,campaign_name
  ,campaign_type_id 
  ,shopper_id
  ,PERIOD
  ,cy_week
  ,gtin_id
  ,campaign_fg
  ,art_hierarchy_level_id
  ,SUM(control_qty) AS control_qty
  ,SUM(test_qty) AS test_qty
  ,SUM(control_val) AS control_val
  ,SUM(test_val) AS test_val
  ,SUM(control_qty_attrib_sales) AS control_qty_attrib_sales
  ,SUM(test_qty_attrib_sales) AS test_qty_attrib_sales
  ,SUM(control_val_attrib_sales) AS control_val_attrib_sales
  ,SUM(test_val_attrib_sales) AS test_val_attrib_sales
FROM core.t_ab_test_result_day_1

GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;
