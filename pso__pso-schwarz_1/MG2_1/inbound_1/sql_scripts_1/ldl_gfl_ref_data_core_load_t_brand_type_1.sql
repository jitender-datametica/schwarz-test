MERGE INTO core_rel.t_brand_type_1 AS target USING (
  SELECT 
    brand_type_cd, 
    lang_cd, 
    brand_type_descr, 
    CURRENT_TIMESTAMP AS dwh_created_tmsp, 
    CURRENT_TIMESTAMP AS dwh_updated_tmsp, 
    ${LOAD_ID} AS dwh_load_id, 
    'MANUAL' AS dwh_node_cd 
  FROM 
    etl.t_brand_type_1 
  MINUS 
  SELECT 
    brand_type_cd, 
    lang_cd, 
    brand_type_descr, 
    CURRENT_TIMESTAMP AS dwh_created_tmsp, 
    CURRENT_TIMESTAMP AS dwh_updated_tmsp, 
    ${LOAD_ID} AS dwh_load_id, 
    'MANUAL' AS dwh_node_cd 
  FROM 
    core_rel.t_brand_type_1
) AS source ON target.brand_type_cd = source.brand_type_cd 
AND target.lang_cd = source.lang_cd 
WHEN matched THEN 
UPDATE 
SET 
  target.brand_type_descr = source.brand_type_descr, 
  dwh_updated_tmsp = CURRENT_TIMESTAMP, 
  dwh_load_id = ${LOAD_ID}, 
  dwh_node_cd = 'MANUAL' 
WHEN NOT matched THEN INSERT (
    brand_type_cd, 
    lang_cd, 
    brand_type_descr, 
    dwh_created_tmsp, 
    dwh_updated_tmsp, 
    dwh_load_id, 
    dwh_node_cd
  ) 
VALUES 
  (
    source.brand_type_cd, 
    source.lang_cd, 
    source.brand_type_descr, 
    CURRENT_TIMESTAMP, 
    CURRENT_TIMESTAMP, 
    ${LOAD_ID},
    'MANUAL'
  );

