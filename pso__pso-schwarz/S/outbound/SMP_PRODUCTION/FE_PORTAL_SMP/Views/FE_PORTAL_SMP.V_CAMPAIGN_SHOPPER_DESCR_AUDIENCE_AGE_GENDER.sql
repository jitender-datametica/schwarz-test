CREATE OR REPLACE VIEW smp_production_fe_portal_smp.v_campaign_shopper_descr_audience_age_gender (division_id,
country_id, campaign_id, campaign_name, advertiser_id_smp, advertiser_id_piq, campaign_type_id, shopper_id, age, age_id
, age_name, gender, gender_id, gender_name) AS SELECT C.division_id,
 C.country_id,
 C.campaign_id,
 C.campaign_name,
 C.advertiser_id_smp,
 C.advertiser_id_piq,
 C.campaign_type_id,
 s.shopper_id,
 MAX(CASE
   WHEN A.descr_audience_type_id = 'AGE'
   THEN A.descr_audience_type_id
   ELSE NULL
   END) AS age,
 MAX(CASE
   WHEN A.descr_audience_type_id = 'AGE'
   THEN A.descr_audience_id
   ELSE NULL
   END) AS age_id,
 MAX(CASE
   WHEN A.descr_audience_type_id = 'AGE'
   THEN A.descr_audience_name
   ELSE NULL
   END) AS age_name,
 MAX(CASE
   WHEN A.descr_audience_type_id = 'GENDER'
   THEN A.descr_audience_type_id
   ELSE NULL
   END) AS gender,
 MAX(CASE
   WHEN A.descr_audience_type_id = 'GENDER'
   THEN A.descr_audience_id
   ELSE NULL
   END) AS gender_id,
 MAX(CASE
   WHEN A.descr_audience_type_id = 'GENDER'
   THEN A.descr_audience_name
   ELSE NULL
   END) AS gender_name
FROM smp_production_core.t_dim_campaign AS C
 INNER JOIN smp_production_fe_portal_smp.v_campaign_portal_permission AS P ON C.division_id = P.division_id AND C.country_id
     = P.country_id AND C.campaign_id = P.campaign_id
 INNER JOIN (SELECT division_id,
   country_id,
   campaign_id,
   shopper_id
  FROM smp_production_core_rel.t_smp_attributed_sales AS S
  GROUP BY division_id,
   country_id,
   campaign_id,
   shopper_id) AS s ON C.division_id = s.division_id AND C.country_id = s.country_id AND C.campaign_id = s.campaign_id
 INNER JOIN smp_production_core_rel.t_map_shopper_descr_audience AS M ON s.division_id = M.division_id AND s.country_id
    = M.country_id AND s.shopper_id = M.shopper_id
 INNER JOIN smp_production_core_rel.t_descr_audience AS A ON M.division_id = A.division_id AND M.country_id = A.country_id
      AND M.descr_audience_id = A.descr_audience_id AND A.descr_audience_type_id IN ('AGE', 'GENDER')
 INNER JOIN smp_production_core_rel.t_descr_audience_type AS T ON A.division_id = T.division_id AND A.country_id = T.country_id
      AND A.descr_audience_type_id = T.descr_audience_type_id AND T.active_fg = 1
GROUP BY C.division_id,
 C.country_id,
 C.campaign_id,
 C.campaign_name,
 C.advertiser_id_smp,
 C.advertiser_id_piq,
 C.campaign_type_id,
 s.shopper_id;