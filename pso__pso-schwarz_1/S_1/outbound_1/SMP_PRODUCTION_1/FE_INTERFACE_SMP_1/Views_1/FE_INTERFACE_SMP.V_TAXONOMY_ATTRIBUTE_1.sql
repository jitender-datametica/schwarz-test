CREATE OR REPLACE VIEW smp_production_fe_interface_smp.v_taxonomy_attribute_1(
  retailer_id,
  country_1,
  attribute_id,
  attribute_name,
  attribute_description,
  load_timestamp
) AS 

WITH tmsp AS 
(
  SELECT 
     division_id,
     country_id,
     MAX(load_timestamp) AS load_timestamp
  FROM smp_production_fe_interface_smp.t_smp_taxonomy_base_1 
  GROUP BY 1, 2 
)

SELECT
   CONCAT(LOWER(d.division_name), '-offline-001-', cc.env) AS retailer_id,
   t.country_id AS country_1,
   t.taxonomy_id AS attribute_id,
   t.taxonomy_name AS attribute_name,
   t.taxonomy_name AS attribute_description,
   b.load_timestamp
FROM 
(
  SELECT division_id, country_id, taxonomy_id, taxonomy_name FROM smp_production_core_rel.t_taxonomy_hierarchy_1 WHERE level = 1 AND taxonomy_type_id = '1'
  UNION DISTINCT 
  SELECT division_id, country_id, taxonomy_id, taxonomy_name FROM smp_production_core_rel.t_taxonomy_hierarchy_1 WHERE level = 2 AND taxonomy_type_id = '1'
  UNION DISTINCT 
  SELECT division_id, country_id, taxonomy_id, taxonomy_name FROM smp_production_core_rel.t_taxonomy_hierarchy_1 WHERE level = 3 AND taxonomy_type_id = '1'
  UNION DISTINCT 
  SELECT division_id, country_id, taxonomy_id, taxonomy_name FROM smp_production_core_rel.t_taxonomy_hierarchy_1 WHERE level = 4 AND taxonomy_type_id = '1'
) AS t

INNER JOIN tmsp AS b 
  ON t.division_id = b.division_id
  AND t.country_id = b.country_id

INNER JOIN smp_production_core_rel.t_division_1 AS d
  ON t.division_id = d.division_id

CROSS JOIN 
(
  SELECT 
    'prod' AS env
) AS cc

QUALIFY ROW_NUMBER() OVER 
(
  PARTITION BY t.division_id, t.country_id, t.taxonomy_id 
  ORDER BY t.taxonomy_name
) = 1;