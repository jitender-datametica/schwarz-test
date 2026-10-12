create or replace view SMP_PRODUCTION.FE_MSTR_SMP.V_DOOH_CAMPAIGN_AGE_GENDER_2(
	DIVISION_ID,
	COUNTRY_ID,
	CAMPAIGN_ID,
	AGE,
	FEMALE_CNT,
	MALE_CNT,
	FAMILY_CNT,
	UNKNOWN_CNT
) as 
SELECT  
   a.division_id 
  ,a.country_id
  ,a.campaign_id 
  ,COALESCE(ad.descr_audience_id, 'AGE00000 Age unknown')   AS age
  ,SUM(CASE WHEN gd.descr_audience_id = 'GENDER00001' THEN 1 ELSE 0 END) AS female_cnt
  ,SUM(CASE WHEN gd.descr_audience_id = 'GENDER00002' THEN 1 ELSE 0 END) AS male_cnt
  ,SUM(CASE WHEN gd.descr_audience_id = 'GENDER00003' THEN 1 ELSE 0 END) AS family_cnt
  ,SUM(CASE WHEN gd.descr_audience_id = 'GENDER00000' OR gd.descr_audience_id IS NULL THEN 1 ELSE 0 END) AS unknown_cnt
FROM 
(
  SELECT 
     f.division_id
    ,f.country_id 
    ,f.campaign_id
    ,f.shopper_id
  FROM core.v_ab_test_result_week_2 f
    
  WHERE f.campaign_type_id = 'DOOH' 
    AND f.PERIOD = '2 CAMPAIGN'
    AND f.campaign_fg = 1    
)a


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
  
GROUP BY 1,2,3,4
;
