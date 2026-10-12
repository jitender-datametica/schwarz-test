MERGE INTO core_rel.t_planning_process AS target USING (
  SELECT 
    planning_process_cd, 
    planning_process_descr, 
    CURRENT_TIMESTAMP AS dwh_created_tmsp, 
    CURRENT_TIMESTAMP AS dwh_updated_tmsp, 
    ${LOAD_ID} AS dwh_load_id, 
    'CSV' AS dwh_node_cd 
  FROM 
    etl.t_planning_process 
  MINUS 
  SELECT 
    planning_process_cd, 
    planning_process_descr, 
    CURRENT_TIMESTAMP AS dwh_created_tmsp, 
    CURRENT_TIMESTAMP AS dwh_updated_tmsp, 
    ${LOAD_ID} AS dwh_load_id, 
    'CSV' AS dwh_node_cd 
  FROM 
    core_rel.t_planning_process
) AS source ON target.planning_process_cd = source.planning_process_cd 
WHEN matched THEN 
UPDATE 
SET 
  target.planning_process_descr = source.planning_process_descr, 
  dwh_updated_tmsp = CURRENT_TIMESTAMP, 
  dwh_load_id = ${LOAD_ID}, 
  dwh_node_cd = 'CSV' 
WHEN NOT matched THEN INSERT (
    planning_process_cd, 
    planning_process_descr, 
    dwh_created_tmsp, 
    dwh_updated_tmsp, 
    dwh_load_id, 
    dwh_node_cd
  ) 
VALUES 
  (
    source.planning_process_cd, 
    source.planning_process_descr, 
    CURRENT_TIMESTAMP, 
    CURRENT_TIMESTAMP, 
    ${LOAD_ID},
    'CSV'
  );

commit;

