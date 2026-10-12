MERGE INTO meta.t_product_key_type_2 AS target USING (
  SELECT 
    prod_key_type_cd,
    prod_key_type_name,
    prod_key_type_descr, 
    CURRENT_TIMESTAMP AS dwh_created_tmsp, 
    CURRENT_TIMESTAMP AS dwh_updated_tmsp, 
    ${LOAD_ID} AS dwh_load_id, 
    'MANUAL' AS dwh_node_cd     -- Asked for verification on this as spec says 'HQ_WAWIADM'
  FROM 
    etl.t_product_key_type_2 
  MINUS 
  SELECT 
    prod_key_type_cd,
    prod_key_type_name,
    prod_key_type_descr, 
    CURRENT_TIMESTAMP AS dwh_created_tmsp, 
    CURRENT_TIMESTAMP AS dwh_updated_tmsp, 
    ${LOAD_ID} AS dwh_load_id, 
    'MANUAL' AS dwh_node_cd 
  FROM 
    meta.t_product_key_type_2
) AS source ON target.prod_key_type_cd = source.prod_key_type_cd 
WHEN matched THEN 
UPDATE 
SET 
  target.prod_key_type_descr = source.prod_key_type_descr, 
  target.prod_key_type_name = source.prod_key_type_name,
  dwh_updated_tmsp = CURRENT_TIMESTAMP, 
  dwh_load_id = ${LOAD_ID}, 
  dwh_node_cd = 'MANUAL' 
WHEN NOT matched THEN INSERT (
    prod_key_type_cd, 
    prod_key_type_name, 
    prod_key_type_descr, 
    dwh_created_tmsp, 
    dwh_updated_tmsp, 
    dwh_load_id, 
    dwh_node_cd
  ) 
VALUES 
  (
    source.prod_key_type_cd, 
    source.prod_key_type_name, 
    source.prod_key_type_descr, 
    CURRENT_TIMESTAMP, 
    CURRENT_TIMESTAMP, 
    ${LOAD_ID},
    'MANUAL'
  );

