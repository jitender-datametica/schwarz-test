MERGE INTO ldl_data_production_meta.t_product_variant_key_type AS target
USING (SELECT prod_variant_key_type_cd,
   prod_variant_key_type_name,
   prod_variant_key_type_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${LOAD_ID} AS dwh_load_id,
   'MANUAL' AS dwh_node_cd
  FROM ldl_data_production_etl.t_product_variant_key_type
  EXCEPT DISTINCT
  SELECT prod_variant_key_type_cd,
   prod_variant_key_type_name,
   prod_variant_key_type_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${LOAD_ID} AS dwh_load_id,
   'MANUAL' AS dwh_node_cd
  FROM ldl_data_production_meta.t_product_variant_key_type) AS t1
ON target.prod_variant_key_type_cd = t1.prod_variant_key_type_cd
WHEN MATCHED THEN UPDATE SET
 prod_variant_key_type_descr = t1.prod_variant_key_type_descr,
 prod_variant_key_type_name = t1.prod_variant_key_type_name,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = ROUND(CAST(${LOAD_ID} AS BIGNUMERIC), 0),
 dwh_node_cd = 'MANUAL'
WHEN NOT MATCHED THEN INSERT VALUES(t1.prod_variant_key_type_cd, t1.prod_variant_key_type_name, t1.prod_variant_key_type_descr
 , CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), ROUND(CAST(${LOAD_ID} AS BIGNUMERIC), 0), 'MANUAL');