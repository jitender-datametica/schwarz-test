MERGE INTO ldl_data_production_core_rel.t_wawi_item_variant_status_type_1 AS target
USING (SELECT ROUND(CAST(wawi_item_variant_status_type_id AS BIGNUMERIC), 0) AS wawi_item_variant_status_type_id,
   lang_cd,
   wawi_item_variant_status_type_name,
   wawi_item_variant_status_type_descr
  FROM ldl_data_production_etl.t_wawi_item_variant_status_type_1
  EXCEPT DISTINCT
  SELECT wawi_item_variant_status_type_id,
   lang_cd,
   wawi_item_variant_status_type_name,
   wawi_item_variant_status_type_descr
  FROM ldl_data_production_core_rel.t_wawi_item_variant_status_type_1) AS t1_1
ON target.wawi_item_variant_status_type_id = t1.wawi_item_variant_status_type_id AND target.lang_cd = t1.lang_cd
WHEN MATCHED THEN UPDATE SET
 wawi_item_variant_status_type_name = t1.wawi_item_variant_status_type_name,
 wawi_item_variant_status_type_descr = t1.wawi_item_variant_status_type_descr,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = ROUND(CAST(${LOAD_ID} AS BIGNUMERIC), 0),
 dwh_node_cd = 'MANUAL'
WHEN NOT MATCHED THEN INSERT VALUES(t1.wawi_item_variant_status_type_id, t1.lang_cd, t1.wawi_item_variant_status_type_name
 , t1.wawi_item_variant_status_type_descr, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), ROUND(CAST(${LOAD_ID} AS BIGNUMERIC)
  , 0), 'MANUAL');