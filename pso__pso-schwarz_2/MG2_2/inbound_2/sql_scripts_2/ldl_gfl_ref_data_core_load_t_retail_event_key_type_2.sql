-- Apply the changes as INSERTs or UPDATES ignoring any unchanged rows.
MERGE INTO meta.t_retail_event_key_type_2 AS target USING (
  SELECT 
    retail_event_key_type_cd,
    retail_event_key_type_name,
    retail_event_key_type_descr, 
    CURRENT_TIMESTAMP AS dwh_created_tmsp, 
    CURRENT_TIMESTAMP AS dwh_updated_tmsp, 
    ${LOAD_ID} AS dwh_load_id, 
    'MANUAL' AS dwh_node_cd     -- Asked for verification on this as spec says 'HQ_WAWIADM'
  FROM 
    etl.t_retail_event_key_type_2 
  MINUS 
  SELECT 
    retail_event_key_type_cd,
    retail_event_key_type_name,
    retail_event_key_type_descr, 
    CURRENT_TIMESTAMP AS dwh_created_tmsp, 
    CURRENT_TIMESTAMP AS dwh_updated_tmsp, 
    ${LOAD_ID} AS dwh_load_id, 
    'MANUAL' AS dwh_node_cd 
  FROM 
    meta.t_retail_event_key_type_2
) AS source ON target.retail_event_key_type_cd = source.retail_event_key_type_cd 
WHEN matched THEN 
UPDATE 
SET 
  target.retail_event_key_type_descr = source.retail_event_key_type_descr, 
  target.retail_event_key_type_name = source.retail_event_key_type_name,
  dwh_updated_tmsp = CURRENT_TIMESTAMP, 
  dwh_load_id = ${LOAD_ID}, 
  dwh_node_cd = 'MANUAL' 
WHEN NOT matched THEN INSERT (
    retail_event_key_type_cd, 
    retail_event_key_type_name, 
    retail_event_key_type_descr, 
    dwh_created_tmsp, 
    dwh_updated_tmsp, 
    dwh_load_id, 
    dwh_node_cd
  ) 
VALUES 
  (
    source.retail_event_key_type_cd, 
    source.retail_event_key_type_name, 
    source.retail_event_key_type_descr, 
    CURRENT_TIMESTAMP, 
    CURRENT_TIMESTAMP, 
    ${LOAD_ID},
    'MANUAL'
  );

commit;

