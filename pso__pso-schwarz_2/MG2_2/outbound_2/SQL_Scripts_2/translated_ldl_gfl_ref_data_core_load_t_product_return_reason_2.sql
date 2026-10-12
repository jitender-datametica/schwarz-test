-- Apply the changes as INSERTs or UPDATES ignoring any unchanged rows.



MERGE INTO ldl_data_production_core_rel.t_product_return_reason_2 AS target
USING (SELECT prod_return_reason_sid,
   lang_cd,
   prod_return_reason_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${LOAD_ID} AS dwh_load_id,
   'MANUAL' AS dwh_node_cd
  FROM ldl_data_production_etl.t_product_return_reason_2
  EXCEPT DISTINCT
  SELECT prod_return_reason_sid,
   lang_cd,
   prod_return_reason_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${LOAD_ID} AS dwh_load_id,
   'MANUAL' AS dwh_node_cd
  FROM ldl_data_production_core_rel.t_product_return_reason_2) AS t1_2
ON target.prod_return_reason_sid = t1.prod_return_reason_sid AND target.lang_cd = t1.lang_cd
WHEN MATCHED THEN UPDATE SET
 prod_return_reason_descr = t1.prod_return_reason_descr,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = ROUND(CAST(${LOAD_ID} AS BIGNUMERIC), 0),
 dwh_node_cd = 'MANUAL'
WHEN NOT MATCHED THEN INSERT VALUES(t1.prod_return_reason_sid, t1.lang_cd, t1.prod_return_reason_descr,
 CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), ROUND(CAST(${LOAD_ID} AS BIGNUMERIC), 0), 'MANUAL');


commit;