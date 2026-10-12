
-- Apply the changes as INSERTs or UPDATES ignoring any unchanged rows.



-- Asked for verification on this as spec says 'HQ_WAWIADM'


MERGE INTO ldl_data_production_meta.t_inventory_key_type_1 AS target
USING (SELECT inv_key_type_cd,
   inv_key_type_name,
   inv_key_type_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${load_id} AS dwh_load_id,
   'MANUAL' AS dwh_node_cd
  FROM ldl_data_production_etl.t_inventory_key_type_1
  EXCEPT DISTINCT
  SELECT inv_key_type_cd,
   inv_key_type_name,
   inv_key_type_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${load_id} AS dwh_load_id,
   'MANUAL' AS dwh_node_cd
  FROM ldl_data_production_meta.t_inventory_key_type_1) AS t1_1
ON target.inv_key_type_cd = t1.inv_key_type_cd
WHEN MATCHED THEN UPDATE SET
 inv_key_type_descr = t1.inv_key_type_descr,
 inv_key_type_name = t1.inv_key_type_name,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = ROUND(CAST(target.${load_id} AS BIGNUMERIC), 0),
 dwh_node_cd = 'MANUAL'
WHEN NOT MATCHED THEN INSERT (inv_key_type_cd, inv_key_type_name, inv_key_type_descr, dwh_created_tmsp, dwh_updated_tmsp
 , dwh_load_id, dwh_node_cd) VALUES(t1.inv_key_type_cd, t1.inv_key_type_name, t1.inv_key_type_descr, CURRENT_TIMESTAMP()
 , CURRENT_TIMESTAMP(), ROUND(CAST(target.${load_id} AS BIGNUMERIC), 0), 'MANUAL');


commit