MERGE INTO ldl_data_production_core_rel.t_product_variant_status_type_2 AS target
USING (SELECT *
  FROM ldl_data_production_etl.t_product_variant_status_type_2
  EXCEPT DISTINCT
  SELECT prod_variant_status_type_cd,
   lang_cd,
   prod_variant_status_type_descr
  FROM ldl_data_production_core_rel.t_product_variant_status_type_2) AS t0
ON target.prod_variant_status_type_cd = t0.prod_variant_status_type_cd AND target.lang_cd = t0.lang_cd
WHEN MATCHED THEN UPDATE SET
 prod_variant_status_type_descr = t0.prod_variant_status_type_descr,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = ROUND(CAST(${LOAD_ID} AS BIGNUMERIC), 0),
 dwh_node_cd = 'MANUAL'
WHEN NOT MATCHED THEN INSERT VALUES(t0.prod_variant_status_type_cd, t0.lang_cd, t0.prod_variant_status_type_descr,
 CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), ROUND(CAST(${LOAD_ID} AS BIGNUMERIC), 0), 'MANUAL');