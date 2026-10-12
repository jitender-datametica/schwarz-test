CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dooh_campaign_age_gender_1 (division_id, country_id, campaign_id, age
, female_cnt, male_cnt, family_cnt, unknown_cnt) AS SELECT a.division_id,
 a.country_id,
 a.campaign_id,
 COALESCE(AD.descr_audience_id, 'AGE00000 Age unknown') AS age,
 SUM(CASE
   WHEN GD.descr_audience_id = 'GENDER00001'
   THEN 1
   ELSE 0
   END) AS female_cnt,
 SUM(CASE
   WHEN GD.descr_audience_id = 'GENDER00002'
   THEN 1
   ELSE 0
   END) AS male_cnt,
 SUM(CASE
   WHEN GD.descr_audience_id = 'GENDER00003'
   THEN 1
   ELSE 0
   END) AS family_cnt,
 SUM(CASE
   WHEN GD.descr_audience_id IS NULL OR GD.descr_audience_id = 'GENDER00000'
   THEN 1
   ELSE 0
   END) AS unknown_cnt
FROM (SELECT division_id,
   country_id,
   campaign_id,
   shopper_id
  FROM smp_production_core.v_ab_test_result_week_1 AS F
  WHERE campaign_type_id = 'DOOH'
   AND period = '2 CAMPAIGN'
   AND campaign_fg = 1) AS a
 LEFT JOIN smp_production_core_rel.t_map_shopper_descr_audience_1 AS AD ON a.division_id = AD.division_id AND a.country_id
      = AD.country_id AND a.shopper_id = AD.shopper_id AND AD.descr_audience_id LIKE 'AGE%'
 LEFT JOIN smp_production_core_rel.t_descr_audience_1 AS C ON AD.division_id = C.division_id AND AD.country_id = C.country_id
     AND AD.descr_audience_id = C.descr_audience_id
 LEFT JOIN smp_production_core_rel.t_map_shopper_descr_audience_1 AS GD ON a.division_id = GD.division_id AND a.country_id
      = GD.country_id AND a.shopper_id = GD.shopper_id AND GD.descr_audience_id LIKE 'GENDER%'
GROUP BY a.division_id,
 a.country_id,
 a.campaign_id,
 age;