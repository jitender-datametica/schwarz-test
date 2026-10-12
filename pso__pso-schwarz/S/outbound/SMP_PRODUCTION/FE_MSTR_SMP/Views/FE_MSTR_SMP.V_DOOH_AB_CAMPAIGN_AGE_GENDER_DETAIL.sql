CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dooh_ab_campaign_age_gender_detail (division_id, country_id,
campaign_id, age, female_control_qty, male_control_qty, family_control_qty, unknown_control_qty, female_test_qty,
male_test_qty, family_test_qty, unknown_test_qty) AS SELECT a.division_id,
 a.country_id,
 a.campaign_id,
 COALESCE(AD.descr_audience_id, 'AGE00000 Age unknown') AS age,
 SUM(CASE
   WHEN GD.descr_audience_id = 'GENDER00001'
   THEN a.control_qty
   ELSE 0
   END) AS female_control_qty,
 SUM(CASE
   WHEN GD.descr_audience_id = 'GENDER00002'
   THEN a.control_qty
   ELSE 0
   END) AS male_control_qty,
 SUM(CASE
   WHEN GD.descr_audience_id = 'GENDER00003'
   THEN a.control_qty
   ELSE 0
   END) AS family_control_qty,
 SUM(CASE
   WHEN COALESCE(GD.descr_audience_id, 'GENDER00000') = 'GENDER00000'
   THEN a.control_qty
   ELSE 0
   END) AS unknown_control_qty,
 SUM(CASE
   WHEN GD.descr_audience_id = 'GENDER00001'
   THEN a.test_qty
   ELSE 0
   END) AS female_test_qty,
 SUM(CASE
   WHEN GD.descr_audience_id = 'GENDER00002'
   THEN a.test_qty
   ELSE 0
   END) AS male_test_qty,
 SUM(CASE
   WHEN GD.descr_audience_id = 'GENDER00003'
   THEN a.test_qty
   ELSE 0
   END) AS family_test_qty,
 SUM(CASE
   WHEN COALESCE(GD.descr_audience_id, 'GENDER00000') = 'GENDER00000'
   THEN a.test_qty
   ELSE 0
   END) AS unknown_test_qty
FROM (SELECT division_id,
   country_id,
   campaign_id,
   shopper_id,
   SUM(control_qty) AS control_qty,
   SUM(test_qty) AS test_qty
  FROM smp_production_core.v_ab_test_result_week AS F
  WHERE campaign_type_id = 'DOOH'
   AND period = '2 CAMPAIGN'
   AND campaign_fg = 1
  GROUP BY division_id,
   country_id,
   campaign_id,
   shopper_id) AS a
 LEFT JOIN smp_production_core_rel.t_map_shopper_descr_audience AS AD ON a.division_id = AD.division_id AND a.country_id
      = AD.country_id AND a.shopper_id = AD.shopper_id AND AD.descr_audience_id LIKE 'AGE%'
 LEFT JOIN smp_production_core_rel.t_descr_audience AS C ON AD.division_id = C.division_id AND AD.country_id = C.country_id
     AND AD.descr_audience_id = C.descr_audience_id
 LEFT JOIN smp_production_core_rel.t_map_shopper_descr_audience AS GD ON a.division_id = GD.division_id AND a.country_id
      = GD.country_id AND a.shopper_id = GD.shopper_id AND GD.descr_audience_id LIKE 'GENDER%'
GROUP BY a.division_id,
 a.country_id,
 a.campaign_id,
 age;