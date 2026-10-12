UPDATE ldl_data_production_etl_process.t_wawi_extract_control_status_1 SET LAST_SCN = T_WAWI_EXTRACT_CONTROL_STATUS.MAX_SCN, DWH_UPDATED_TMSP = current_timestamp(), DWH_LOAD_ID = cast ('LOAD_ID' as bignumeric)
 WHERE T_WAWI_EXTRACT_CONTROL_STATUS.SCHEMA_NAME = upper('whwawiadm')
 AND T_WAWI_EXTRACT_CONTROL_STATUS.TABLE_NAME = upper('t180_stinventory_1')
 AND T_WAWI_EXTRACT_CONTROL_STATUS.AI_GRAPH_NAME = '${AI_GRAPH_NAME}';
UPDATE ldl_data_production_etl_process.t_wawi_extract_control_status_1 SET LAST_SCN = T_WAWI_EXTRACT_CONTROL_STATUS.MAX_SCN, DWH_UPDATED_TMSP = current_timestamp(), DWH_LOAD_ID = cast('LOAD_ID' as bignumeric)
 WHERE T_WAWI_EXTRACT_CONTROL_STATUS.SCHEMA_NAME = upper('whwawiadm')
 AND T_WAWI_EXTRACT_CONTROL_STATUS.TABLE_NAME = upper('t182_sic_inventory_1')
 AND T_WAWI_EXTRACT_CONTROL_STATUS.AI_GRAPH_NAME = '${AI_GRAPH_NAME}';
