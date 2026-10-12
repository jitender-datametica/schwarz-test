MERGE INTO ldl_data_production_core_rel.t_product_container_assortment_area AS target
USING (SELECT country || '|' || id_local AS prod_container_assort_area_cd,
    CASE
    WHEN country = 'GB'
    THEN 'EN'
    ELSE 'DE'
    END AS lang_cd,
   desc_int AS prod_container_assort_area_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${LOAD_ID} AS dwh_load_id,
   'MANUAL' AS dwh_node_cd
  FROM ldl_data_production_etl_process.t_cache_product_container_assortment_area
  EXCEPT DISTINCT
  SELECT prod_container_assort_area_cd,
   lang_cd,
   prod_container_assort_area_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${LOAD_ID} AS dwh_load_id,
   'MANUAL' AS dwh_node_cd
  FROM ldl_data_production_core_rel.t_product_container_assortment_area) AS t1
ON target.prod_container_assort_area_cd = t1.prod_container_assort_area_cd AND target.lang_cd = t1.lang_cd
WHEN MATCHED THEN UPDATE SET
 prod_container_assort_area_descr = t1.prod_container_assort_area_descr,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = ROUND(CAST(${LOAD_ID} AS BIGNUMERIC), 0),
 dwh_node_cd = 'MANUAL'
WHEN NOT MATCHED THEN INSERT VALUES(t1.prod_container_assort_area_cd, t1.lang_cd, t1.prod_container_assort_area_descr,
 CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), ROUND(CAST(${LOAD_ID} AS BIGNUMERIC), 0), 'MANUAL');