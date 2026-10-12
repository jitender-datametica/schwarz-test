MERGE INTO core_rel.t_product_variant_status_type_2 AS target USING (
  SELECT 
    prod_variant_status_type_cd, 
    lang_cd, 
    prod_variant_status_type_descr
  FROM 
    etl.t_product_variant_status_type_2 
  MINUS 
  SELECT 
    prod_variant_status_type_cd, 
    lang_cd, 
    prod_variant_status_type_descr
  FROM 
    core_rel.t_product_variant_status_type_2
) AS source ON target.prod_variant_status_type_cd = source.prod_variant_status_type_cd 
AND target.lang_cd = source.lang_cd 
WHEN matched THEN 
UPDATE 
SET 
  target.prod_variant_status_type_descr = source.prod_variant_status_type_descr, 
  dwh_updated_tmsp = CURRENT_TIMESTAMP, 
  dwh_load_id = ${LOAD_ID}, 
  dwh_node_cd = 'MANUAL' 
WHEN NOT matched THEN INSERT (
    prod_variant_status_type_cd, 
    lang_cd, 
    prod_variant_status_type_descr, 
    dwh_created_tmsp, 
    dwh_updated_tmsp, 
    dwh_load_id, 
    dwh_node_cd
  ) 
VALUES 
  (
    source.prod_variant_status_type_cd, 
    source.lang_cd, 
    source.prod_variant_status_type_descr, 
    CURRENT_TIMESTAMP, 
    CURRENT_TIMESTAMP, 
    ${LOAD_ID},
    'MANUAL'
  );
