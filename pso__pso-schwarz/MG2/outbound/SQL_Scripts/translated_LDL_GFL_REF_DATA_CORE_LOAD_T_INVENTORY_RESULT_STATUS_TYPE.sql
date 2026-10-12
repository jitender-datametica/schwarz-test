
-- Apply the changes as INSERTs or UPDATES ignoring any unchanged rows.



MERGE INTO ldl_data_production_core_rel.t_inventory_result_status_type AS target
USING (SELECT inv_result_status_type_id,
   lang_cd,
   inv_result_status_type_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${load_id} AS dwh_load_id,
   'MANUAL' AS dwh_node_cd
  FROM ldl_data_production_etl.t_inventory_result_status_type
  EXCEPT DISTINCT
  SELECT inv_result_status_type_id,
   lang_cd,
   inv_result_status_type_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${load_id} AS dwh_load_id,
   'MANUAL' AS dwh_node_cd
  FROM ldl_data_production_core_rel.t_inventory_result_status_type) AS t1
ON target.inv_result_status_type_id = t1.inv_result_status_type_id AND target.lang_cd = t1.lang_cd
WHEN MATCHED THEN UPDATE SET
 inv_result_status_type_descr = t1.inv_result_status_type_descr,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = ROUND(CAST(target.${load_id} AS BIGNUMERIC), 0),
 dwh_node_cd = 'MANUAL'
WHEN NOT MATCHED THEN INSERT (inv_result_status_type_descr, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd
 , inv_result_status_type_id, lang_cd) VALUES(t1.inv_result_status_type_descr, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()
 , ROUND(CAST(target.${load_id} AS BIGNUMERIC), 0), 'MANUAL', t1.inv_result_status_type_id, t1.lang_cd);


commit