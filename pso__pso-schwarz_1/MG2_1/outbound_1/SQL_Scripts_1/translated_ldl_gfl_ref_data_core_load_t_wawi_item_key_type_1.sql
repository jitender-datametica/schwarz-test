MERGE INTO ldl_data_production_meta.t_wawi_item_key_type_1 AS target
USING (SELECT wawi_item_key_type_cd,
   wawi_item_key_type_name,
   wawi_item_key_type_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${LOAD_ID} AS dwh_load_id,
   'MANUAL' AS dwh_node_cd
  FROM ldl_data_production_etl.t_wawi_item_key_type_1
  EXCEPT DISTINCT
  SELECT wawi_item_key_type_cd,
   wawi_item_key_type_name,
   wawi_item_key_type_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${LOAD_ID} AS dwh_load_id,
   'MANUAL' AS dwh_node_cd
  FROM ldl_data_production_meta.t_wawi_item_key_type_1) AS t1_1
ON target.wawi_item_key_type_cd = t1.wawi_item_key_type_cd
WHEN MATCHED THEN UPDATE SET
 wawi_item_key_type_name = t1.wawi_item_key_type_name,
 wawi_item_key_type_descr = t1.wawi_item_key_type_descr,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = ROUND(CAST(${LOAD_ID} AS BIGNUMERIC), 0),
 dwh_node_cd = 'MANUAL'
WHEN NOT MATCHED THEN INSERT VALUES(t1.wawi_item_key_type_cd, t1.wawi_item_key_type_name, t1.wawi_item_key_type_descr,
 CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), ROUND(CAST(${LOAD_ID} AS BIGNUMERIC), 0), 'MANUAL');