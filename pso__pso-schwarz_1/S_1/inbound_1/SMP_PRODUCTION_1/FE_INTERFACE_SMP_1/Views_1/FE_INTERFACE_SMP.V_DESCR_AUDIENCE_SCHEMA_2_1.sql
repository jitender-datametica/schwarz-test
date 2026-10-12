create or replace view SMP_PRODUCTION.FE_INTERFACE_SMP.V_DESCR_AUDIENCE_SCHEMA_2_1(
	METADATA_ID,
	RETAILER_ID,
	COUNTRY_1,
	SHOPPER_ID,
	LOAD_TIMESTAMP
) as 
SELECT 
   m.descr_audience_id AS metadata_id
  ,LOWER(D.division_name) || '-offline-001-' || c.env AS retailer_id 
  ,m.country_id AS country_1  
  ,m.shopper_id 
  ,CONVERT_TIMEZONE('UTC', m.create_tmsp)::TIMESTAMPNTZ AS load_timestamp 
FROM core_rel.t_map_shopper_descr_audience_1 m

INNER JOIN core_rel.t_descr_audience_1 a
ON m.division_id = a.division_id
  AND m.country_id = a.country_id
  AND m.descr_audience_id = a.descr_audience_id

INNER JOIN core_rel.t_descr_audience_type_1 T
ON a.division_id = T.division_id
  AND a.country_id = T.country_id
  AND a.descr_audience_type_id = T.descr_audience_type_id
  AND T.active_fg = 1 

INNER JOIN core_rel.t_division_1 D
ON m.division_id = D.division_id 

INNER JOIN 
(
  SELECT 
    CASE database_name 
         WHEN 'SMP_PRODUCTION' THEN 'prod'
         ELSE 'stage'
    END AS env
  FROM information_schema.DATABASES 
  WHERE database_name = CURRENT_DATABASE()
) c
ON 1=1
;
