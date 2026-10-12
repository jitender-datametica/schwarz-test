-- Apply the changes as INSERTs or UPDATES ignoring any unchanged rows.
MERGE INTO core_rel.t_inventory_type_1 AS target USING (
  SELECT 
    inv_type_cd, 
    lang_cd,
    inv_type_descr, 
    CURRENT_TIMESTAMP AS dwh_created_tmsp, 
    CURRENT_TIMESTAMP AS dwh_updated_tmsp, 
    ${LOAD_ID} AS dwh_load_id, 
    'MANUAL' AS dwh_node_cd 
  FROM 
    etl.t_inventory_type_1
  MINUS 
  SELECT 
    inv_type_cd, 
    lang_cd,    
    inv_type_descr, 
    CURRENT_TIMESTAMP AS dwh_created_tmsp, 
    CURRENT_TIMESTAMP AS dwh_updated_tmsp, 
    ${LOAD_ID} AS dwh_load_id, 
    'MANUAL' AS dwh_node_cd 
  FROM 
    core_rel.t_inventory_type_1
) AS source 
ON target.inv_type_cd = source.inv_type_cd
AND target.lang_cd = source.lang_cd 
WHEN matched THEN 
UPDATE 
SET 
  target.inv_type_descr = source.inv_type_descr, 
  dwh_updated_tmsp = CURRENT_TIMESTAMP, 
  dwh_load_id = ${LOAD_ID}, 
  dwh_node_cd = 'MANUAL' 
WHEN NOT matched THEN INSERT (
    inv_type_cd, 
    lang_cd,
    inv_type_descr, 
    dwh_created_tmsp, 
    dwh_updated_tmsp, 
    dwh_load_id, 
    dwh_node_cd
  ) 
VALUES 
  (
    source.inv_type_cd, 
    source.lang_cd,
    source.inv_type_descr, 
    CURRENT_TIMESTAMP, 
    CURRENT_TIMESTAMP, 
    ${LOAD_ID},
    'MANUAL'
  );

commit;
