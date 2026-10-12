MERGE INTO ldl_data_production_core_rel.t_planned_value_role_1 AS target
USING (SELECT planned_val_role_cd,
   lang_cd,
   planned_val_role_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${LOAD_ID} AS dwh_load_id,
   'MANUAL' AS dwh_node_cd
  FROM ldl_data_production_etl.t_planned_value_role_1
  EXCEPT DISTINCT
  SELECT planned_val_role_cd,
   lang_cd,
   planned_val_role_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${LOAD_ID} AS dwh_load_id,
   'MANUAL' AS dwh_node_cd
  FROM ldl_data_production_core_rel.t_planned_value_role_1) AS t1_1
ON target.planned_val_role_cd = t1.planned_val_role_cd AND target.lang_cd = t1.lang_cd
WHEN MATCHED THEN UPDATE SET
 planned_val_role_descr = t1.planned_val_role_descr,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = ROUND(CAST(${LOAD_ID} AS BIGNUMERIC), 0),
 dwh_node_cd = 'MANUAL'
WHEN NOT MATCHED THEN INSERT VALUES(t1.planned_val_role_cd, t1.lang_cd, t1.planned_val_role_descr, CURRENT_TIMESTAMP(),
 CURRENT_TIMESTAMP(), ROUND(CAST(${LOAD_ID} AS BIGNUMERIC), 0), 'MANUAL');


commit;