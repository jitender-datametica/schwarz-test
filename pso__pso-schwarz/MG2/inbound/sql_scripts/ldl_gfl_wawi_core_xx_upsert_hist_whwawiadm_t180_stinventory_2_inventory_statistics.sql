UPDATE etl_process.t_wawi_extract_control_status
SET last_scn = max_scn
    ,dwh_updated_tmsp = CURRENT_TIMESTAMP
    ,dwh_load_id = ${LOAD_ID}
WHERE schema_name=UPPER('whwawiadm') AND table_name=UPPER('t180_stinventory') AND ai_graph_name='${AI_GRAPH_NAME}';

UPDATE etl_process.t_wawi_extract_control_status
SET last_scn = max_scn
    ,dwh_updated_tmsp = CURRENT_TIMESTAMP
    ,dwh_load_id = ${LOAD_ID}
WHERE schema_name=UPPER('whwawiadm') AND table_name=UPPER('t182_sic_inventory') AND ai_graph_name='${AI_GRAPH_NAME}';
