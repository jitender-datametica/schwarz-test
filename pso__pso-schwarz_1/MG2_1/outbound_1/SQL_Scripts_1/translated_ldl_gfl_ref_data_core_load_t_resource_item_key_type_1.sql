-- Apply the changes as INSERTs or UPDATES ignoring any unchanged rows.



MERGE INTO ldl_data_production_meta.t_resource_item_key_type_1 AS target
USING (SELECT resource_item_key_type_cd,
   resource_item_key_type_name,
   resource_item_key_type_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${LOAD_ID} AS dwh_load_id,
   'MANUAL' AS dwh_node_cd
  FROM ldl_data_production_etl.t_resource_item_key_type_1
  EXCEPT DISTINCT
  SELECT resource_item_key_type_cd,
   resource_item_key_type_name,
   resource_item_key_type_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${LOAD_ID} AS dwh_load_id,
   'MANUAL' AS dwh_node_cd
  FROM ldl_data_production_meta.t_resource_item_key_type_1) AS t1_1
ON target.resource_item_key_type_cd = t1.resource_item_key_type_cd
WHEN MATCHED THEN UPDATE SET
 resource_item_key_type_descr = t1.resource_item_key_type_descr,
 resource_item_key_type_name = t1.resource_item_key_type_name,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = ROUND(CAST(${LOAD_ID} AS BIGNUMERIC), 0),
 dwh_node_cd = 'MANUAL'
WHEN NOT MATCHED THEN INSERT VALUES(t1.resource_item_key_type_cd, t1.resource_item_key_type_name, t1.resource_item_key_type_descr
 , CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), ROUND(CAST(${LOAD_ID} AS BIGNUMERIC), 0), 'MANUAL');


commit;