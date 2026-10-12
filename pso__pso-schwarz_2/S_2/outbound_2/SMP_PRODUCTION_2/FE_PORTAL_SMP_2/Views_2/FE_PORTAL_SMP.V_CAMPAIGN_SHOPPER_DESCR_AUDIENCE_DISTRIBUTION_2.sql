CREATE OR REPLACE VIEW smp_production_fe_portal_smp.v_campaign_shopper_descr_audience_distribution_2 (division_id,
country_id, campaign_id, campaign_name, advertiser_id_smp, advertiser_id_piq, campaign_type_id, descr_audience_type_id,
descr_audience_id, descr_audience_name, shopper_descr_audience_pct) AS SELECT C.division_id,
 C.country_id,
 C.campaign_id,
 C.campaign_name,
 C.advertiser_id_smp,
 C.advertiser_id_piq,
 C.campaign_type_id,
 a.descr_audience_type_id,
 a.descr_audience_id,
 a.descr_audience_name,
 ROUND(CAST(IF(a.anz_shopper = 0 OR a.anz_shopper IS NULL, 0, SAFE_DIVIDE(a.anz_shopper_descr_audience, a.anz_shopper)) * 100 AS NUMERIC)
  , 3) AS shopper_descr_audience_pct
FROM smp_production_core.t_dim_campaign_2 AS C
 INNER JOIN smp_production_fe_portal_smp.v_campaign_portal_permission_2 AS P ON C.division_id = P.division_id AND C.country_id
     = P.country_id AND C.campaign_id = P.campaign_id
 INNER JOIN (SELECT S.division_id,
   S.country_id,
   S.campaign_id,
   S.shopper_id,
   A.descr_audience_type_id,
   A.descr_audience_id,
   A.descr_audience_name,
   COUNT(S.shopper_id) OVER (PARTITION BY S.division_id, S.country_id, S.campaign_id RANGE BETWEEN UNBOUNDED PRECEDING
    AND UNBOUNDED FOLLOWING) AS anz_shopper,
   COUNT(S.shopper_id) OVER (PARTITION BY S.division_id, S.country_id, S.campaign_id, A.descr_audience_id RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS anz_shopper_descr_audience
  FROM smp_production_core_rel.t_smp_attributed_sales_2 AS S
   INNER JOIN smp_production_core_rel.t_map_shopper_descr_audience_2 AS M ON S.division_id = M.division_id AND S.country_id
       = M.country_id AND S.shopper_id = M.shopper_id
   INNER JOIN smp_production_core_rel.t_descr_audience_2 AS A ON M.division_id = A.division_id AND M.country_id = A.country_id
       AND M.descr_audience_id = A.descr_audience_id
   INNER JOIN smp_production_core_rel.t_descr_audience_type_2 AS T ON A.division_id = T.division_id AND A.country_id = T.country_id
        AND A.descr_audience_type_id = T.descr_audience_type_id AND T.active_fg = 1
  GROUP BY S.division_id,
   S.country_id,
   S.campaign_id,
   S.shopper_id,
   A.descr_audience_type_id,
   A.descr_audience_id,
   A.descr_audience_name) AS a ON C.division_id = a.division_id AND C.country_id = a.country_id AND C.campaign_id = a.campaign_id
   
GROUP BY C.division_id,
 C.country_id,
 C.campaign_id,
 C.campaign_name,
 C.advertiser_id_smp,
 C.advertiser_id_piq,
 C.campaign_type_id,
 a.descr_audience_type_id,
 a.descr_audience_id,
 a.descr_audience_name,
 shopper_descr_audience_pct;
