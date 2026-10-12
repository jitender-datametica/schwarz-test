MERGE INTO core_rel.t_wawi_item_variant_status_type_2 AS target USING (
  SELECT 
    wawi_item_variant_status_type_id, 
    lang_cd, 
    wawi_item_variant_status_type_name,
    wawi_item_variant_status_type_descr
  FROM 
    etl.t_wawi_item_variant_status_type_2 
  MINUS 
  SELECT 
    wawi_item_variant_status_type_id, 
    lang_cd, 
    wawi_item_variant_status_type_name,
    wawi_item_variant_status_type_descr
  FROM 
    core_rel.t_wawi_item_variant_status_type_2
) AS source ON target.wawi_item_variant_status_type_id = source.wawi_item_variant_status_type_id 
AND target.lang_cd = source.lang_cd 
WHEN matched THEN 
UPDATE 
SET 
  target.wawi_item_variant_status_type_name = source.wawi_item_variant_status_type_name,
  target.wawi_item_variant_status_type_descr = source.wawi_item_variant_status_type_descr, 
  dwh_updated_tmsp = CURRENT_TIMESTAMP, 
  dwh_load_id = ${LOAD_ID}, 
  dwh_node_cd = 'MANUAL' 
WHEN NOT matched THEN INSERT (
    wawi_item_variant_status_type_id, 
    lang_cd, 
    wawi_item_variant_status_type_name, 
    wawi_item_variant_status_type_descr, 
    dwh_created_tmsp, 
    dwh_updated_tmsp, 
    dwh_load_id, 
    dwh_node_cd
  ) 
VALUES 
  (
    source.wawi_item_variant_status_type_id, 
    source.lang_cd, 
    source.wawi_item_variant_status_type_name, 
    source.wawi_item_variant_status_type_descr, 
    CURRENT_TIMESTAMP, 
    CURRENT_TIMESTAMP, 
    ${LOAD_ID},
    'MANUAL'
  );
