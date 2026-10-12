MERGE INTO core_rel.t_product_container_class_1 AS target USING (
  SELECT 
    prod_container_class_cd,
    lang_cd,
    prod_container_class_descr, 
    CURRENT_TIMESTAMP AS dwh_created_tmsp, 
    CURRENT_TIMESTAMP AS dwh_updated_tmsp, 
    ${LOAD_ID} AS dwh_load_id, 
    'MANUAL' AS dwh_node_cd    
  FROM 
    etl.t_product_container_class_1 
  MINUS 
  SELECT 
    prod_container_class_cd,
    lang_cd,
    prod_container_class_descr, 
    CURRENT_TIMESTAMP AS dwh_created_tmsp, 
    CURRENT_TIMESTAMP AS dwh_updated_tmsp, 
    ${LOAD_ID} AS dwh_load_id, 
    'MANUAL' AS dwh_node_cd 
  FROM 
    core_rel.t_product_container_class_1
) AS source ON target.prod_container_class_cd = source.prod_container_class_cd  AND target.lang_cd = source.lang_cd
WHEN matched THEN 
UPDATE 
SET 
  target.prod_container_class_descr = source.prod_container_class_descr, 
  dwh_updated_tmsp = CURRENT_TIMESTAMP, 
  dwh_load_id = ${LOAD_ID}, 
  dwh_node_cd = 'MANUAL' 
WHEN NOT matched THEN INSERT (
    prod_container_class_cd, 
    lang_cd,
    prod_container_class_descr, 
    dwh_created_tmsp, 
    dwh_updated_tmsp, 
    dwh_load_id, 
    dwh_node_cd
  ) 
VALUES 
  (
    source.prod_container_class_cd, 
    lang_cd,
    source.prod_container_class_descr, 
    CURRENT_TIMESTAMP, 
    CURRENT_TIMESTAMP, 
    ${LOAD_ID},
    'MANUAL'
  );
