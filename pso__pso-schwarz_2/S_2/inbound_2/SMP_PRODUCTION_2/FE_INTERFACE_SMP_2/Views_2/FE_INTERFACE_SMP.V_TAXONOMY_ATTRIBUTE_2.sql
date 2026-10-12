create or replace view SMP_PRODUCTION.FE_INTERFACE_SMP.V_TAXONOMY_ATTRIBUTE_2(
	RETAILER_ID,
	COUNTRY_2,
	ATTRIBUTE_ID,
	ATTRIBUTE_NAME,
	ATTRIBUTE_DESCRIPTION,
	LOAD_TIMESTAMP
) as 

WITH tmsp AS 
(
  SELECT 
     division_id
    ,country_id 
    ,MAX(load_timestamp) AS load_timestamp
  FROM fe_interface_smp.t_smp_taxonomy_base_2 
  GROUP BY 1,2 
)

SELECT
   LOWER(D.division_name) || '-offline-001-' || cc.env AS retailer_id 
  ,T.country_id AS country_2
  ,T.taxonomy_id AS attribute_id
  ,T.taxonomy_name AS attribute_name
  ,T.taxonomy_name AS attribute_description
  ,b.load_timestamp
FROM 
(
  SELECT division_id, country_id, taxonomy_id, taxonomy_name FROM core_rel.t_taxonomy_hierarchy_2 WHERE LEVEL = 1 AND taxonomy_type_id = 1
  UNION 
  SELECT division_id, country_id, taxonomy_id, taxonomy_name FROM core_rel.t_taxonomy_hierarchy_2 WHERE LEVEL = 2 AND taxonomy_type_id = 1
  UNION 
  SELECT division_id, country_id, taxonomy_id, taxonomy_name FROM core_rel.t_taxonomy_hierarchy_2 WHERE LEVEL = 3 AND taxonomy_type_id = 1
  UNION 
  SELECT division_id, country_id, taxonomy_id, taxonomy_name FROM core_rel.t_taxonomy_hierarchy_2 WHERE LEVEL = 4 AND taxonomy_type_id = 1
) T

INNER JOIN tmsp b 
ON t.division_id = b.division_id
  AND t.country_id = b.country_id

INNER JOIN core_rel.t_division_2 D
ON t.division_id = D.division_id


INNER JOIN 
(
  SELECT 
    CASE database_name 
         WHEN 'SMP_PRODUCTION' THEN 'prod'
         ELSE 'stage'
    END AS env
  FROM information_schema.DATABASES 
  WHERE database_name = CURRENT_DATABASE()
) cc
ON 1=1

QUALIFY ROW_NUMBER() OVER 
(
  PARTITION BY T.division_id, T.country_id, T.taxonomy_id 
  ORDER BY T.taxonomy_name
) = 1
;
