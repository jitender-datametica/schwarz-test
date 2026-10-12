CREATE OR REPLACE VIEW smp_production_fe_interface_smp.v_descr_audience_schema_2_2(
  metadata_id,
  retailer_id,
  country_2,
  shopper_id,
  load_timestamp
) AS 
SELECT 
   m.descr_audience_id AS metadata_id,
   CONCAT(LOWER(d.division_name), '-offline-001-', c.env) AS retailer_id,
   m.country_id AS country_2,
   m.shopper_id,
   DATETIME(CAST(m.create_tmsp AS TIMESTAMP), 'UTC') AS load_timestamp 
FROM smp_production_core_rel.t_map_shopper_descr_audience_2 AS m

INNER JOIN smp_production_core_rel.t_descr_audience_2 AS a
  ON m.division_id = a.division_id
  AND m.country_id = a.country_id
  AND m.descr_audience_id = a.descr_audience_id

INNER JOIN smp_production_core_rel.t_descr_audience_type_2 AS t
  ON a.division_id = t.division_id
  AND a.country_id = t.country_id
  AND a.descr_audience_type_id = t.descr_audience_type_id
  AND t.active_fg = 1 

INNER JOIN smp_production_core_rel.t_division_2 AS d
  ON m.division_id = d.division_id 

CROSS JOIN 
(
  SELECT 
    'prod' AS env
) AS c;