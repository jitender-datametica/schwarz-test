create or replace view SMP_PRODUCTION.FE_INTERFACE_SMP.V_DESCR_AUDIENCE_SCHEMA_1_2(
	METADATA_ID,
	RETAILER_ID,
	COUNTRY_2,
	ATTRIBUTE_ID,
	ATTRIBUTE_NAME,
	ATTRIBUTE_VALUE,
	LOAD_TIMESTAMP
) as

WITH audience_ref AS 
(
  SELECT 
     division_id
    ,country_id
    ,descr_audience_id
    ,MAX(CONVERT_TIMEZONE('UTC', create_tmsp)::TIMESTAMPNTZ) AS load_timestamp
  FROM core_rel.t_map_shopper_descr_audience_2
  GROUP BY 1,2,3
)

SELECT 
   m.descr_audience_id AS metadata_id 
  ,LOWER(D.division_name) || '-offline-001-' || c.env AS retailer_id 
  ,m.country_id AS country_2
  
  ,m.descr_audience_type_id || '_' || m.division_id || '_' || m.country_id AS attribute_id
  ,T.descr_audience_type_name AS attribute_name
  ,m.descr_audience_value AS attribute_value 
  ,a.load_timestamp
FROM core_rel.t_descr_audience_2 m

INNER JOIN core_rel.t_descr_audience_type_2 T
ON m.division_id = T.division_id
  AND m.country_id = T.country_id
  AND m.descr_audience_type_id = T.descr_audience_type_id
  AND T.active_fg = 1 

INNER JOIN core_rel.t_division_2 D
ON m.division_id = D.division_id 


INNER JOIN audience_ref a 
ON m.division_id = a.division_id
  AND m.country_id = a. country_id
  AND m.descr_audience_id = a.descr_audience_id


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
