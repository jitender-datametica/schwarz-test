create or replace view SMP_PRODUCTION.FE_MSTR_SMP.V_DOOH_AB_CAMPAIGN_AGE_GENDER_DETAIL(
	DIVISION_ID,
	COUNTRY_ID,
	CAMPAIGN_ID,
	AGE,
	FEMALE_CONTROL_QTY,
	MALE_CONTROL_QTY,
	FAMILY_CONTROL_QTY,
	UNKNOWN_CONTROL_QTY,
	FEMALE_TEST_QTY,
	MALE_TEST_QTY,
	FAMILY_TEST_QTY,
	UNKNOWN_TEST_QTY
) as 
SELECT  
   a.division_id 
  ,a.country_id
  ,a.campaign_id 
  ,COALESCE(ad.descr_audience_id, 'AGE00000 Age unknown') AS age
  ,SUM(CASE WHEN gd.descr_audience_id = 'GENDER00001' THEN control_qty ELSE 0 END) AS female_control_qty
  ,SUM(CASE WHEN gd.descr_audience_id = 'GENDER00002' THEN control_qty ELSE 0 END) AS male_control_qty
  ,SUM(CASE WHEN gd.descr_audience_id = 'GENDER00003' THEN control_qty ELSE 0 END) AS family_control_qty
  ,SUM(CASE WHEN COALESCE(gd.descr_audience_id, 'GENDER00000') = 'GENDER00000' THEN control_qty ELSE 0 END) AS unknown_control_qty
   
  ,SUM(CASE WHEN gd.descr_audience_id = 'GENDER00001' THEN test_qty ELSE 0 END) AS female_test_qty
  ,SUM(CASE WHEN gd.descr_audience_id = 'GENDER00002' THEN test_qty ELSE 0 END) AS male_test_qty
  ,SUM(CASE WHEN gd.descr_audience_id = 'GENDER00003' THEN test_qty ELSE 0 END) AS family_test_qty
  ,SUM(CASE WHEN COALESCE(gd.descr_audience_id, 'GENDER00000') = 'GENDER00000' THEN test_qty ELSE 0 END) AS unknown_test_qty
FROM 
(
  SELECT 
     f.division_id
    ,f.country_id 
    ,f.campaign_id 
    ,f.shopper_id
    ,SUM(f.control_qty) AS control_qty
    ,SUM(f.test_qty) AS test_qty    
  FROM core.v_ab_test_result_week f
    
  WHERE f.campaign_type_id = 'DOOH'
    AND f.PERIOD = '2 CAMPAIGN'
    AND f.campaign_fg = 1
   
  GROUP BY 1,2,3,4
)a


LEFT OUTER JOIN core_rel.t_map_shopper_descr_audience ad
ON ad.division_id = a.division_id 
  AND ad.country_id = a.country_id 
  AND ad.shopper_id = a.shopper_id 
  AND ad.descr_audience_id LIKE ('AGE%')
  
LEFT OUTER JOIN core_rel.t_descr_audience c
ON ad.division_id = c.division_id 
  AND ad.country_id = c.country_id 
  AND ad.descr_audience_id = c.descr_audience_id 


LEFT OUTER JOIN core_rel.t_map_shopper_descr_audience gd
ON gd.division_id = a.division_id 
  AND gd.country_id = a.country_id 
  AND gd.shopper_id = a.shopper_id 
  AND gd.descr_audience_id LIKE ('GENDER%')
  
GROUP BY 1,2,3,4
;
