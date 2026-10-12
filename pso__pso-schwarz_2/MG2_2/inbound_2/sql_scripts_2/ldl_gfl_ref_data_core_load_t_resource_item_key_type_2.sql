-- Apply the changes as INSERTs or UPDATES ignoring any unchanged rows.
MERGE INTO meta.t_resource_item_key_type_2 AS target USING (
  SELECT 
    resource_item_key_type_cd,
    resource_item_key_type_name,
    resource_item_key_type_descr, 
    CURRENT_TIMESTAMP AS dwh_created_tmsp, 
    CURRENT_TIMESTAMP AS dwh_updated_tmsp, 
    ${LOAD_ID} AS dwh_load_id, 
    'MANUAL' AS dwh_node_cd     -- Asked for verification on this as spec says 'HQ_WAWIADM'
  FROM 
    etl.t_resource_item_key_type_2 
  MINUS 
  SELECT 
    resource_item_key_type_cd,
    resource_item_key_type_name,
    resource_item_key_type_descr, 
    CURRENT_TIMESTAMP AS dwh_created_tmsp, 
    CURRENT_TIMESTAMP AS dwh_updated_tmsp, 
    ${LOAD_ID} AS dwh_load_id, 
    'MANUAL' AS dwh_node_cd 
  FROM 
    meta.t_resource_item_key_type_2
) AS source ON target.resource_item_key_type_cd = source.resource_item_key_type_cd 
WHEN matched THEN 
UPDATE 
SET 
  target.resource_item_key_type_descr = source.resource_item_key_type_descr, 
  target.resource_item_key_type_name = source.resource_item_key_type_name,
  dwh_updated_tmsp = CURRENT_TIMESTAMP, 
  dwh_load_id = ${LOAD_ID}, 
  dwh_node_cd = 'MANUAL' 
WHEN NOT matched THEN INSERT (
    resource_item_key_type_cd, 
    resource_item_key_type_name, 
    resource_item_key_type_descr, 
    dwh_created_tmsp, 
    dwh_updated_tmsp, 
    dwh_load_id, 
    dwh_node_cd
  ) 
VALUES 
  (
    source.resource_item_key_type_cd, 
    source.resource_item_key_type_name, 
    source.resource_item_key_type_descr, 
    CURRENT_TIMESTAMP, 
    CURRENT_TIMESTAMP, 
    ${LOAD_ID},
    'MANUAL'
  );

commit;

