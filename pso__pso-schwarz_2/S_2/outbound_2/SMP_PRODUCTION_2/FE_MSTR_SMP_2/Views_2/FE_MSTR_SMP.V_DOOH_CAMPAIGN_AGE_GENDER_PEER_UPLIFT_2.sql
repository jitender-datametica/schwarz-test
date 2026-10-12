CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dooh_campaign_age_gender_peer_uplift_2 (division_id, country_id,
campaign_id, campaign_name, age, female, male, family, all_gender) AS SELECT a.division_id,
 a.country_id,
 a.campaign_id,
 a.campaign_name,
  CASE
  WHEN t3.faecher = 1
  THEN COALESCE(AD.descr_audience_id, 'AGE00000')
  ELSE 'AGE_ALL'
  END AS age,
  IF(IF(SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00001'
        THEN a.pre_qty_control
        ELSE 0
        END) = 0, 0, SAFE_DIVIDE(SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00001'
        THEN a.campaign_qty_control
        ELSE 0
        END), SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00001'
        THEN a.pre_qty_control
        ELSE 0
        END))) = 0, 0, SAFE_DIVIDE(IF(SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00001'
        THEN a.pre_qty_test
        ELSE 0
        END) = 0, 0, SAFE_DIVIDE(SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00001'
        THEN a.campaign_qty_test
        ELSE 0
        END), SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00001'
        THEN a.pre_qty_test
        ELSE 0
        END))), IF(SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00001'
        THEN a.pre_qty_control
        ELSE 0
        END) = 0, 0, SAFE_DIVIDE(SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00001'
        THEN a.campaign_qty_control
        ELSE 0
        END), SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00001'
        THEN a.pre_qty_control
        ELSE 0
        END))))) - 1 AS female,
  IF(IF(SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00002'
        THEN a.pre_qty_control
        ELSE 0
        END) = 0, 0, SAFE_DIVIDE(SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00002'
        THEN a.campaign_qty_control
        ELSE 0
        END), SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00002'
        THEN a.pre_qty_control
        ELSE 0
        END))) = 0, 0, SAFE_DIVIDE(IF(SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00002'
        THEN a.pre_qty_test
        ELSE 0
        END) = 0, 0, SAFE_DIVIDE(SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00002'
        THEN a.campaign_qty_test
        ELSE 0
        END), SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00002'
        THEN a.pre_qty_test
        ELSE 0
        END))), IF(SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00002'
        THEN a.pre_qty_control
        ELSE 0
        END) = 0, 0, SAFE_DIVIDE(SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00002'
        THEN a.campaign_qty_control
        ELSE 0
        END), SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00002'
        THEN a.pre_qty_control
        ELSE 0
        END))))) - 1 AS male,
  IF(IF(SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00003'
        THEN a.pre_qty_control
        ELSE 0
        END) = 0, 0, SAFE_DIVIDE(SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00003'
        THEN a.campaign_qty_control
        ELSE 0
        END), SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00003'
        THEN a.pre_qty_control
        ELSE 0
        END))) = 0, 0, SAFE_DIVIDE(IF(SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00003'
        THEN a.pre_qty_test
        ELSE 0
        END) = 0, 0, SAFE_DIVIDE(SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00003'
        THEN a.campaign_qty_test
        ELSE 0
        END), SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00003'
        THEN a.pre_qty_test
        ELSE 0
        END))), IF(SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00003'
        THEN a.pre_qty_control
        ELSE 0
        END) = 0, 0, SAFE_DIVIDE(SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00003'
        THEN a.campaign_qty_control
        ELSE 0
        END), SUM(CASE
        WHEN GD.descr_audience_id = 'GENDER00003'
        THEN a.pre_qty_control
        ELSE 0
        END))))) - 1 AS family,
  IF(IF(SUM(CASE
           WHEN GD.descr_audience_id = 'GENDER00001'
           THEN a.pre_qty_control
           ELSE 0
           END) + SUM(CASE
           WHEN GD.descr_audience_id = 'GENDER00002'
           THEN a.pre_qty_control
           ELSE 0
           END) + SUM(CASE
          WHEN GD.descr_audience_id = 'GENDER00003'
          THEN a.pre_qty_control
          ELSE 0
          END) + SUM(CASE
         WHEN COALESCE(GD.descr_audience_id, 'GENDER00000') = 'GENDER00000'
         THEN a.pre_qty_control
         ELSE 0
         END) = 0, 0, SAFE_DIVIDE(SUM(CASE
           WHEN GD.descr_audience_id = 'GENDER00001'
           THEN a.campaign_qty_control
           ELSE 0
           END) + SUM(CASE
           WHEN GD.descr_audience_id = 'GENDER00002'
           THEN a.campaign_qty_control
           ELSE 0
           END) + SUM(CASE
          WHEN GD.descr_audience_id = 'GENDER00003'
          THEN a.campaign_qty_control
          ELSE 0
          END) + SUM(CASE
         WHEN COALESCE(GD.descr_audience_id, 'GENDER00000') = 'GENDER00000'
         THEN a.campaign_qty_control
         ELSE 0
         END), SUM(CASE
           WHEN GD.descr_audience_id = 'GENDER00001'
           THEN a.pre_qty_control
           ELSE 0
           END) + SUM(CASE
           WHEN GD.descr_audience_id = 'GENDER00002'
           THEN a.pre_qty_control
           ELSE 0
           END) + SUM(CASE
          WHEN GD.descr_audience_id = 'GENDER00003'
          THEN a.pre_qty_control
          ELSE 0
          END) + SUM(CASE
         WHEN COALESCE(GD.descr_audience_id, 'GENDER00000') = 'GENDER00000'
         THEN a.pre_qty_control
         ELSE 0
         END))) = 0, 0, SAFE_DIVIDE(IF(SUM(CASE
           WHEN GD.descr_audience_id = 'GENDER00001'
           THEN a.pre_qty_test
           ELSE 0
           END) + SUM(CASE
           WHEN GD.descr_audience_id = 'GENDER00002'
           THEN a.pre_qty_test
           ELSE 0
           END) + SUM(CASE
          WHEN GD.descr_audience_id = 'GENDER00003'
          THEN a.pre_qty_test
          ELSE 0
          END) + SUM(CASE
         WHEN COALESCE(GD.descr_audience_id, 'GENDER00000') = 'GENDER00000'
         THEN a.pre_qty_test
         ELSE 0
         END) = 0, 0, SAFE_DIVIDE(SUM(CASE
           WHEN GD.descr_audience_id = 'GENDER00001'
           THEN a.campaign_qty_test
           ELSE 0
           END) + SUM(CASE
           WHEN GD.descr_audience_id = 'GENDER00002'
           THEN a.campaign_qty_test
           ELSE 0
           END) + SUM(CASE
          WHEN GD.descr_audience_id = 'GENDER00003'
          THEN a.campaign_qty_test
          ELSE 0
          END) + SUM(CASE
         WHEN COALESCE(GD.descr_audience_id, 'GENDER00000') = 'GENDER00000'
         THEN a.campaign_qty_test
         ELSE 0
         END), SUM(CASE
           WHEN GD.descr_audience_id = 'GENDER00001'
           THEN a.pre_qty_test
           ELSE 0
           END) + SUM(CASE
           WHEN GD.descr_audience_id = 'GENDER00002'
           THEN a.pre_qty_test
           ELSE 0
           END) + SUM(CASE
          WHEN GD.descr_audience_id = 'GENDER00003'
          THEN a.pre_qty_test
          ELSE 0
          END) + SUM(CASE
         WHEN COALESCE(GD.descr_audience_id, 'GENDER00000') = 'GENDER00000'
         THEN a.pre_qty_test
         ELSE 0
         END))), IF(SUM(CASE
           WHEN GD.descr_audience_id = 'GENDER00001'
           THEN a.pre_qty_control
           ELSE 0
           END) + SUM(CASE
           WHEN GD.descr_audience_id = 'GENDER00002'
           THEN a.pre_qty_control
           ELSE 0
           END) + SUM(CASE
          WHEN GD.descr_audience_id = 'GENDER00003'
          THEN a.pre_qty_control
          ELSE 0
          END) + SUM(CASE
         WHEN COALESCE(GD.descr_audience_id, 'GENDER00000') = 'GENDER00000'
         THEN a.pre_qty_control
         ELSE 0
         END) = 0, 0, SAFE_DIVIDE(SUM(CASE
           WHEN GD.descr_audience_id = 'GENDER00001'
           THEN a.campaign_qty_control
           ELSE 0
           END) + SUM(CASE
           WHEN GD.descr_audience_id = 'GENDER00002'
           THEN a.campaign_qty_control
           ELSE 0
           END) + SUM(CASE
          WHEN GD.descr_audience_id = 'GENDER00003'
          THEN a.campaign_qty_control
          ELSE 0
          END) + SUM(CASE
         WHEN COALESCE(GD.descr_audience_id, 'GENDER00000') = 'GENDER00000'
         THEN a.campaign_qty_control
         ELSE 0
         END), SUM(CASE
           WHEN GD.descr_audience_id = 'GENDER00001'
           THEN a.pre_qty_control
           ELSE 0
           END) + SUM(CASE
           WHEN GD.descr_audience_id = 'GENDER00002'
           THEN a.pre_qty_control
           ELSE 0
           END) + SUM(CASE
          WHEN GD.descr_audience_id = 'GENDER00003'
          THEN a.pre_qty_control
          ELSE 0
          END) + SUM(CASE
         WHEN COALESCE(GD.descr_audience_id, 'GENDER00000') = 'GENDER00000'
         THEN a.pre_qty_control
         ELSE 0
         END))))) - 1 AS all_gender
FROM (SELECT division_id,
   country_id,
   campaign_id,
   campaign_name,
   shopper_id,
   SUM(CASE
     WHEN period = '2 CAMPAIGN'
     THEN test_qty
     ELSE 0
     END) AS campaign_qty_test,
   SUM(CASE
     WHEN period = '1 PRE'
     THEN test_qty
     ELSE 0
     END) AS pre_qty_test,
   SUM(CASE
     WHEN period = '2 CAMPAIGN'
     THEN control_qty
     ELSE 0
     END) AS campaign_qty_control,
   SUM(CASE
     WHEN period = '1 PRE'
     THEN control_qty
     ELSE 0
     END) AS pre_qty_control
  FROM smp_production_core.v_ab_test_result_week_2 AS R
  WHERE campaign_type_id = 'DOOH'
   AND campaign_fg = 1
   AND period IN ('1 PRE', '2 CAMPAIGN')
  GROUP BY division_id,
   country_id,
   campaign_id,
   campaign_name,
   shopper_id) AS a
 LEFT JOIN smp_production_core_rel.t_map_shopper_descr_audience_2 AS AD ON a.division_id = AD.division_id AND a.country_id
      = AD.country_id AND a.shopper_id = AD.shopper_id AND AD.descr_audience_id LIKE 'AGE%'
 LEFT JOIN smp_production_core_rel.t_descr_audience_2 AS C ON AD.division_id = C.division_id AND AD.country_id = C.country_id
     AND AD.descr_audience_id = C.descr_audience_id
 LEFT JOIN smp_production_core_rel.t_map_shopper_descr_audience_2 AS GD ON a.division_id = GD.division_id AND a.country_id
      = GD.country_id AND a.shopper_id = GD.shopper_id AND GD.descr_audience_id LIKE 'GENDER%'
 INNER JOIN (SELECT 1 AS faecher
   UNION ALL
   SELECT 2 AS faecher) AS t3 ON TRUE
GROUP BY a.division_id,
 a.country_id,
 a.campaign_id,
 a.campaign_name,
 age;