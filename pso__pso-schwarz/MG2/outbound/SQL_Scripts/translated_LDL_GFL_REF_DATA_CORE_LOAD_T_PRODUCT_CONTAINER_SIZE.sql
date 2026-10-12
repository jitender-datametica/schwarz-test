
MERGE INTO ldl_data_production_core_rel.t_product_container_size AS target
USING (SELECT prod_container_size_cd,
   lang_cd,
   prod_container_size_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${load_id} AS dwh_load_id,
   'MANUAL' AS dwh_node_cd
  FROM ldl_data_production_etl.t_product_container_size
  EXCEPT DISTINCT
  SELECT prod_container_size_cd,
   lang_cd,
   prod_container_size_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${load_id} AS dwh_load_id,
   'MANUAL' AS dwh_node_cd
  FROM ldl_data_production_core_rel.t_product_container_size) AS t1
ON target.prod_container_size_cd = t1.prod_container_size_cd AND target.lang_cd = t1.lang_cd
WHEN MATCHED THEN UPDATE SET
 prod_container_size_descr = t1.prod_container_size_descr,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = ROUND(CAST(target.${load_id} AS BIGNUMERIC), 0),
 dwh_node_cd = 'MANUAL'
WHEN NOT MATCHED THEN INSERT (prod_container_size_cd, lang_cd, prod_container_size_descr, dwh_created_tmsp,
 dwh_updated_tmsp, dwh_load_id, dwh_node_cd) VALUES(t1.prod_container_size_cd, t1.lang_cd, t1.prod_container_size_descr
 , CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), ROUND(CAST(target.${load_id} AS BIGNUMERIC), 0), 'MANUAL');