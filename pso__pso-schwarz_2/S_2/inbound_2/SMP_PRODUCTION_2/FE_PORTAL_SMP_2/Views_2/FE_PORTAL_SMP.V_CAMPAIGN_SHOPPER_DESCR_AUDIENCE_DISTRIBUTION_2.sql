create or replace view SMP_PRODUCTION.FE_PORTAL_SMP.V_CAMPAIGN_SHOPPER_DESCR_AUDIENCE_DISTRIBUTION_2(
	DIVISION_ID,
	COUNTRY_ID,
	CAMPAIGN_ID,
	CAMPAIGN_NAME,
	ADVERTISER_ID_SMP,
	ADVERTISER_ID_PIQ,
	CAMPAIGN_TYPE_ID,
	DESCR_AUDIENCE_TYPE_ID,
	DESCR_AUDIENCE_ID,
	DESCR_AUDIENCE_NAME,
	SHOPPER_DESCR_AUDIENCE_PCT
) as 
SELECT 
   c.division_id
  ,c.country_id 
  ,c.campaign_id
  ,c.campaign_name 
  ,c.advertiser_id_smp
  ,c.advertiser_id_piq
  ,c.campaign_type_id 
  ,a.descr_audience_type_id
  ,a.descr_audience_id
  ,a.descr_audience_name
  ,CAST(DIV0NULL(a.anz_shopper_descr_audience, a.anz_shopper)*100 AS NUMBER(18,3)) AS shopper_descr_audience_pct
FROM core.t_dim_campaign_2 c 
  

INNER JOIN fe_portal_smp.v_campaign_portal_permission_2 p
ON c.division_id = p.division_id
  AND c.country_id = p.country_id
  AND c.campaign_id = p.campaign_id

INNER JOIN 
(
  SELECT 
     s.division_id
    ,s.country_id
    ,s.campaign_id
    ,s.shopper_id
    ,a.descr_audience_type_id
    ,a.descr_audience_id
    ,a.descr_audience_name  
    ,COUNT(DISTINCT(s.shopper_id)) OVER (PARTITION BY s.division_id, s.country_id, s.campaign_id) AS anz_shopper
    ,COUNT(DISTINCT(s.shopper_id)) OVER (PARTITION BY s.division_id, s.country_id, s.campaign_id, a.descr_audience_id) AS anz_shopper_descr_audience
  FROM core_rel.t_smp_attributed_sales_2 s
  
  INNER JOIN core_rel.t_map_shopper_descr_audience_2 m
  ON s.division_id = m.division_id
    AND s.country_id = m.country_id 
    AND s.shopper_id = m.shopper_id 
    
  INNER JOIN core_rel.t_descr_audience_2 a
  ON m.division_id = a.division_id
    AND m.country_id = a.country_id 
    AND m.descr_audience_id = a.descr_audience_id 
    
  INNER JOIN core_rel.t_descr_audience_type_2 T
  ON a.division_id = t.division_id
    AND a.country_id = t.country_id 
    AND a.descr_audience_type_id = t.descr_audience_type_id 
    AND T.active_fg = 1
  
  GROUP BY 1,2,3,4,5,6,7
) a
ON a.division_id = c.division_id 
  AND a.country_id = c.country_id
  AND a.campaign_id = c.campaign_id 
 
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;
