MERGE INTO core_rel.t_planned_value_role_2 AS target USING (
  SELECT 
    planned_val_role_cd, 
    lang_cd, 
    planned_val_role_descr, 
    CURRENT_TIMESTAMP AS dwh_created_tmsp, 
    CURRENT_TIMESTAMP AS dwh_updated_tmsp, 
    ${LOAD_ID} AS dwh_load_id, 
    'MANUAL' AS dwh_node_cd 
  FROM 
    etl.t_planned_value_role_2 
  MINUS 
  SELECT 
    planned_val_role_cd, 
    lang_cd, 
    planned_val_role_descr, 
    CURRENT_TIMESTAMP AS dwh_created_tmsp, 
    CURRENT_TIMESTAMP AS dwh_updated_tmsp, 
    ${LOAD_ID} AS dwh_load_id, 
    'MANUAL' AS dwh_node_cd 
  FROM 
    core_rel.t_planned_value_role_2
) AS source ON target.planned_val_role_cd = source.planned_val_role_cd 
AND target.lang_cd = source.lang_cd 
WHEN matched THEN 
UPDATE 
SET 
  target.planned_val_role_descr = source.planned_val_role_descr, 
  dwh_updated_tmsp = CURRENT_TIMESTAMP, 
  dwh_load_id = ${LOAD_ID}, 
  dwh_node_cd = 'MANUAL' 
WHEN NOT matched THEN INSERT (
    planned_val_role_cd, 
    lang_cd, 
    planned_val_role_descr, 
    dwh_created_tmsp, 
    dwh_updated_tmsp, 
    dwh_load_id, 
    dwh_node_cd
  ) 
VALUES 
  (
    source.planned_val_role_cd, 
    source.lang_cd, 
    source.planned_val_role_descr, 
    CURRENT_TIMESTAMP, 
    CURRENT_TIMESTAMP, 
    ${LOAD_ID},
    'MANUAL'
  );

commit;

