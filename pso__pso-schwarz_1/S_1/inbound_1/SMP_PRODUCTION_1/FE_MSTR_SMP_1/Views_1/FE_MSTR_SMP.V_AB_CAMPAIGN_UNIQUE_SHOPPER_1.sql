create or replace view SMP_PRODUCTION.FE_MSTR_SMP.V_AB_CAMPAIGN_UNIQUE_SHOPPER_1(
	DIVISION_ID,
	COUNTRY_ID,
	CAMPAIGN_ID,
	CAMPAIGN_NAME,
	CAMPAIGN_TYPE_ID,
	PERIOD,
	CY_WEEK,
	UNIQUE_SHOPPER_CNT,
	UNIQUE_SHOPPER_TEST_CNT,
	UNIQUE_SHOPPER_CONTROL_CNT
) as 
SELECT 
   f.division_id
  ,f.country_Id
  ,f.campaign_id
  ,f.campaign_name 
  ,f.campaign_type_id 
  ,f.PERIOD
  ,f.cy_week
  ,COUNT(DISTINCT(f.shopper_id)) AS unique_shopper_cnt 
  ,COUNT(DISTINCT(CASE WHEN f.cell_group_id = 'TEST_1' THEN f.shopper_id ELSE NULL END)) AS unique_shopper_test_cnt
  ,COUNT(DISTINCT(CASE WHEN f.cell_group_id = 'CONTROL' THEN f.shopper_id ELSE NULL END)) AS unique_shopper_control_cnt
FROM core.t_ab_test_result_day_1 f

WHERE f.campaign_type_id <> 'DOOH' -- bei DooH sind auch unbekannte Shopper_1 enthalten. 
  AND f.campaign_fg = 1 -- nur kampagnenartikel 
  
GROUP BY 1,2,3,4,5,6,7
;
