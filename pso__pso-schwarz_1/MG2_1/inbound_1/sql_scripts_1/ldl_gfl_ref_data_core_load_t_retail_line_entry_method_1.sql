-- Apply the changes as INSERTs or UPDATES ignoring any unchanged rows.
MERGE INTO core_rel.t_retail_line_entry_method_1 AS target USING (
  SELECT 
    retail_line_entry_method_cd, 
    lang_cd, 
    retail_line_entry_method_descr, 
    CURRENT_TIMESTAMP AS dwh_created_tmsp, 
    CURRENT_TIMESTAMP AS dwh_updated_tmsp, 
    ${LOAD_ID} AS dwh_load_id, 
    'MANUAL' AS dwh_node_cd 
  FROM 
    etl.t_retail_line_entry_method_1 
  MINUS 
  SELECT 
    retail_line_entry_method_cd, 
    lang_cd, 
    retail_line_entry_method_descr, 
    CURRENT_TIMESTAMP AS dwh_created_tmsp, 
    CURRENT_TIMESTAMP AS dwh_updated_tmsp, 
    ${LOAD_ID} AS dwh_load_id, 
    'MANUAL' AS dwh_node_cd 
  FROM 
    core_rel.t_retail_line_entry_method_1
) AS source ON target.retail_line_entry_method_cd = source.retail_line_entry_method_cd 
AND target.lang_cd = source.lang_cd 
WHEN matched THEN 
UPDATE 
SET 
  target.retail_line_entry_method_descr = source.retail_line_entry_method_descr, 
  dwh_updated_tmsp = CURRENT_TIMESTAMP, 
  dwh_load_id = ${LOAD_ID}, 
  dwh_node_cd = 'MANUAL' 
WHEN NOT matched THEN INSERT (
    retail_line_entry_method_cd, 
    lang_cd, 
    retail_line_entry_method_descr, 
    dwh_created_tmsp, 
    dwh_updated_tmsp, 
    dwh_load_id, 
    dwh_node_cd
  ) 
VALUES 
  (
    source.retail_line_entry_method_cd, 
    source.lang_cd, 
    source.retail_line_entry_method_descr, 
    CURRENT_TIMESTAMP, 
    CURRENT_TIMESTAMP, 
    ${LOAD_ID},
    'MANUAL'
  );

commit;

