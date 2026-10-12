

UPDATE ldl_data_production_etl_process.t_wawi_extract_control_status_2 SET
 last_scn = t_wawi_extract_control_status.max_scn,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id =CAST('${LOAD_ID}' AS BIGNUMERIC)
WHERE schema_name = UPPER('whwawiadm') AND table_name = UPPER('t180_stinventory_2') AND ai_graph_name = '${AI_GRAPH_NAME}';




UPDATE ldl_data_production_etl_process.t_wawi_extract_control_status_2 SET
 last_scn = t_wawi_extract_control_status.max_scn,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = CAST('${LOAD_ID}'AS BIGNUMERIC)
WHERE schema_name = UPPER('whwawiadm') AND table_name = UPPER('t182_sic_inventory_2') AND ai_graph_name =
  '${AI_GRAPH_NAME}';


