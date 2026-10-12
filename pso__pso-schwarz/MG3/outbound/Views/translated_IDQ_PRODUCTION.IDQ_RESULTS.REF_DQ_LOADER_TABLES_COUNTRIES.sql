CREATE OR REPLACE VIEW idq_production_idq_results.ref_dq_loader_tables_countries (table_id, table_name, branch_id,
source_system_type_id, source_country_id, target_country_id_list, country_id, source_system_type) AS SELECT t.id AS
 table_id,
 t.table_name,
 t.branch_id,
 t.source_system_type_id,
 CAST(v.source_country_id AS STRING) AS source_country_id,
 CAST(v.target_country_id_list AS STRING) AS target_country_id_list,
 VALUE AS country_id,
 sst.name AS source_system_type
FROM idq_production_idq_results.ref_dq_status_loader_source_table AS t
 INNER JOIN idq_production_idq_results.ref_source_system_type AS sst ON t.source_system_type_id = sst.id
 INNER JOIN idq_production_idq_results.ref_dq_status_loader_sst_country_additional_map AS v ON CAST(t.country_id_list AS STRING)
    = CAST(v.source_country_id AS STRING) AND t.source_system_type_id = v.source_system_type_id AND sst.id = v.source_system_type_id
   
 INNER JOIN (SELECT 1 AS SEQ) AS t0 ON TRUE
 INNER JOIN UNNEST(SPLIT(v.target_country_id_list, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE
UNION DISTINCT
SELECT id0 AS id,
 table_name,
 branch_id,
 source_system_type_id,
 CAST(country_id_list AS STRING) AS v2_country_id_list,
 CAST(country_id_list AS STRING) AS v2_country_id_list0,
 VALUE AS country_id,
 name AS source_system_type
FROM (SELECT sst.id,
   sst.name,
   v2.id AS id0,
   v2.branch_id,
   v2.source_system_type_id,
   v2.table_name,
   v2.country_id_list,
   t.SEQ,
    ORDINALITY + 1 AS INDEX,
   VALUE
  FROM idq_production_idq_results.ref_source_system_type AS sst
   INNER JOIN idq_production_idq_results.ref_dq_status_loader_source_table AS v2 ON sst.id = v2.source_system_type_id
   INNER JOIN (SELECT 1 AS SEQ) AS t ON TRUE
   INNER JOIN UNNEST(SPLIT(v2.country_id_list, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AS t4
WHERE NOT EXISTS (SELECT 1
  FROM idq_production_idq_results.ref_dq_status_loader_sst_country_additional_map
  WHERE source_system_type_id = t4.source_system_type_id
   AND CAST(source_country_id AS STRING) = CAST(t4.country_id_list AS STRING));