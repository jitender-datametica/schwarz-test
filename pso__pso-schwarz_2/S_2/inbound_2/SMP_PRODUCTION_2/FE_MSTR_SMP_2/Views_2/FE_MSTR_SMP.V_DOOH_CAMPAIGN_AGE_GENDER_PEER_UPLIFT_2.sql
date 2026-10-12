create or replace view SMP_PRODUCTION.FE_MSTR_SMP.V_DOOH_CAMPAIGN_AGE_GENDER_PEER_UPLIFT_2(
	DIVISION_ID,
	COUNTRY_ID,
	CAMPAIGN_ID,
	CAMPAIGN_NAME,
	AGE,
	FEMALE,
	MALE,
	FAMILY,
	ALL_GENDER
) as 
SELECT 
   a.division_id 
  ,a.country_id
  ,a.campaign_id 
  ,a.campaign_name 
  ,a.age
  ,DIV0(DIV0(female_campaign_test_qty, female_pre_test_qty), DIV0(female_campaign_control_qty, female_pre_control_qty)) -1 AS female
  ,DIV0(DIV0(male_campaign_test_qty, male_pre_test_qty), DIV0(male_campaign_control_qty, male_pre_control_qty)) -1 AS male
  ,DIV0(DIV0(family_campaign_test_qty, family_pre_test_qty), DIV0(family_campaign_control_qty, family_pre_control_qty)) -1 AS family
  ,DIV0
   (
     DIV0
     (
       (female_campaign_test_qty + male_campaign_test_qty + family_campaign_test_qty + unknown_campaign_test_qty)
       ,(female_pre_test_qty + male_pre_test_qty + family_pre_test_qty + unknown_pre_test_qty)
     )
     ,DIV0
     (
       (female_campaign_control_qty + male_campaign_control_qty + family_campaign_control_qty + unknown_campaign_control_qty)
       ,(female_pre_control_qty + male_pre_control_qty + family_pre_control_qty + unknown_pre_control_qty)
     )
   ) - 1 AS all_gender
FROM 
(
  SELECT 
     a.division_id 
    ,a.country_id
    ,a.campaign_id 
    ,a.campaign_name 
    ,CASE WHEN faecher = 1 THEN COALESCE(ad.descr_audience_id, 'AGE00000') ELSE 'AGE_ALL' END AS age 
  
     
    ,SUM(CASE WHEN gd.descr_audience_id = 'GENDER00001' THEN pre_qty_control ELSE 0 END) AS female_pre_control_qty
    ,SUM(CASE WHEN gd.descr_audience_id = 'GENDER00002' THEN pre_qty_control ELSE 0 END) AS male_pre_control_qty
    ,SUM(CASE WHEN gd.descr_audience_id = 'GENDER00003' THEN pre_qty_control ELSE 0 END) AS family_pre_control_qty
    ,SUM(CASE WHEN COALESCE(gd.descr_audience_id, 'GENDER00000') = 'GENDER00000' THEN pre_qty_control ELSE 0 END) AS unknown_pre_control_qty
     
    ,SUM(CASE WHEN gd.descr_audience_id = 'GENDER00001' THEN campaign_qty_control ELSE 0 END) AS female_campaign_control_qty
    ,SUM(CASE WHEN gd.descr_audience_id = 'GENDER00002' THEN campaign_qty_control ELSE 0 END) AS male_campaign_control_qty
    ,SUM(CASE WHEN gd.descr_audience_id = 'GENDER00003' THEN campaign_qty_control ELSE 0 END) AS family_campaign_control_qty
    ,SUM(CASE WHEN COALESCE(gd.descr_audience_id, 'GENDER00000') = 'GENDER00000' THEN campaign_qty_control ELSE 0 END) AS unknown_campaign_control_qty
  
     
    ,SUM(CASE WHEN gd.descr_audience_id = 'GENDER00001' THEN pre_qty_test ELSE 0 END) AS female_pre_test_qty
    ,SUM(CASE WHEN gd.descr_audience_id = 'GENDER00002' THEN pre_qty_test ELSE 0 END) AS male_pre_test_qty
    ,SUM(CASE WHEN gd.descr_audience_id = 'GENDER00003' THEN pre_qty_test ELSE 0 END) AS family_pre_test_qty
    ,SUM(CASE WHEN COALESCE(gd.descr_audience_id, 'GENDER00000') = 'GENDER00000' THEN pre_qty_test ELSE 0 END) AS unknown_pre_test_qty
     
    ,SUM(CASE WHEN gd.descr_audience_id = 'GENDER00001' THEN campaign_qty_test ELSE 0 END) AS female_campaign_test_qty
    ,SUM(CASE WHEN gd.descr_audience_id = 'GENDER00002' THEN campaign_qty_test ELSE 0 END) AS male_campaign_test_qty
    ,SUM(CASE WHEN gd.descr_audience_id = 'GENDER00003' THEN campaign_qty_test ELSE 0 END) AS family_campaign_test_qty
    ,SUM(CASE WHEN COALESCE(gd.descr_audience_id, 'GENDER00000') = 'GENDER00000' THEN campaign_qty_test ELSE 0 END) AS unknown_campaign_test_qty
  FROM 
  (
    SELECT 
       r.division_id
      ,r.country_id
      ,r.campaign_id
      ,r.campaign_name
      ,r.shopper_id 
      ,SUM(CASE WHEN r.PERIOD = '2 CAMPAIGN' THEN r.test_qty ELSE 0 END) AS campaign_qty_test
      ,SUM(CASE WHEN r.PERIOD = '1 PRE' THEN r.test_qty ELSE 0 END) AS pre_qty_test
      ,SUM(CASE WHEN r.PERIOD = '2 CAMPAIGN' THEN r.control_qty ELSE 0 END) AS campaign_qty_control
      ,SUM(CASE WHEN r.PERIOD = '1 PRE' THEN r.control_qty ELSE 0 END) AS pre_qty_control
    FROM core.v_ab_test_result_week_2 r
        
    WHERE r.campaign_type_id = 'DOOH'
      AND r.campaign_fg = 1
      AND r.PERIOD IN ('1 PRE', '2 CAMPAIGN')
      
    GROUP BY 1,2,3,4,5
  ) a
  
  
  LEFT OUTER JOIN core_rel.t_map_shopper_descr_audience_2 ad
  ON ad.division_id = a.division_id 
    AND ad.country_id = a.country_id 
    AND ad.shopper_id = a.shopper_id 
    AND ad.descr_audience_id LIKE ('AGE%')
    
  LEFT OUTER JOIN core_rel.t_descr_audience_2 c
  ON ad.division_id = c.division_id 
    AND ad.country_id = c.country_id 
    AND ad.descr_audience_id = c.descr_audience_id 
  
  
  LEFT OUTER JOIN core_rel.t_map_shopper_descr_audience_2 gd
  ON gd.division_id = a.division_id 
    AND gd.country_id = a.country_id 
    AND gd.shopper_id = a.shopper_id 
    AND gd.descr_audience_id LIKE ('GENDER%')
    
  INNER JOIN 
  (
    SELECT 1 AS faecher 
    UNION 
    SELECT 2 AS faecher 
  )
  ON 1 = 1 
    
  GROUP BY 1,2,3,4,5
) a
;
