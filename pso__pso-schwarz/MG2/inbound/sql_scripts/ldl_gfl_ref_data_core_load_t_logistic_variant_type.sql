MERGE INTO core_rel.t_logistic_variant_type AS target USING (
  SELECT 
    logistic_variant_type_cd, 
    lang_cd, 
    logistic_variant_type_descr, 
    CURRENT_TIMESTAMP AS dwh_created_tmsp, 
    CURRENT_TIMESTAMP AS dwh_updated_tmsp, 
    ${LOAD_ID} AS dwh_load_id, 
    'MANUAL' AS dwh_node_cd 
  FROM 
    etl.t_logistic_variant_type 
  MINUS 
  SELECT 
    logistic_variant_type_cd, 
    lang_cd, 
    logistic_variant_type_descr, 
    CURRENT_TIMESTAMP AS dwh_created_tmsp, 
    CURRENT_TIMESTAMP AS dwh_updated_tmsp, 
    ${LOAD_ID} AS dwh_load_id, 
    'MANUAL' AS dwh_node_cd 
  FROM 
    core_rel.t_logistic_variant_type
) AS source ON target.logistic_variant_type_cd = source.logistic_variant_type_cd 
AND target.lang_cd = source.lang_cd 
WHEN matched THEN 
UPDATE 
SET 
  target.logistic_variant_type_descr = source.logistic_variant_type_descr, 
  dwh_updated_tmsp = CURRENT_TIMESTAMP, 
  dwh_load_id = ${LOAD_ID}, 
  dwh_node_cd = 'MANUAL' 
WHEN NOT matched THEN INSERT (
    logistic_variant_type_cd, 
    lang_cd, 
    logistic_variant_type_descr, 
    dwh_created_tmsp, 
    dwh_updated_tmsp, 
    dwh_load_id, 
    dwh_node_cd
  ) 
VALUES 
  (
    source.logistic_variant_type_cd, 
    source.lang_cd, 
    source.logistic_variant_type_descr, 
    CURRENT_TIMESTAMP, 
    CURRENT_TIMESTAMP, 
    ${LOAD_ID},
    'MANUAL'
  );

