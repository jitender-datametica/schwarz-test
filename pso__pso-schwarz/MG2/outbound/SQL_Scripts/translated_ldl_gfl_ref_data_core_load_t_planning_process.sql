MERGE INTO ldl_data_production_core_rel.t_planning_process AS target
USING (SELECT planning_process_cd,
   planning_process_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${LOAD_ID} AS dwh_load_id,
   'CSV' AS dwh_node_cd
  FROM ldl_data_production_etl.t_planning_process
  EXCEPT DISTINCT
  SELECT planning_process_cd,
   planning_process_descr,
   CURRENT_TIMESTAMP() AS dwh_created_tmsp,
   CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
   ${LOAD_ID} AS dwh_load_id,
   'CSV' AS dwh_node_cd
  FROM ldl_data_production_core_rel.t_planning_process) AS t1
ON target.planning_process_cd = t1.planning_process_cd
WHEN MATCHED THEN UPDATE SET
 planning_process_descr = t1.planning_process_descr,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = ROUND(CAST(${LOAD_ID} AS BIGNUMERIC), 0),
 dwh_node_cd = 'CSV'
WHEN NOT MATCHED THEN INSERT VALUES(t1.planning_process_cd, t1.planning_process_descr, CURRENT_TIMESTAMP(),
 CURRENT_TIMESTAMP(), ROUND(CAST(${LOAD_ID} AS BIGNUMERIC), 0), 'CSV');


commit;