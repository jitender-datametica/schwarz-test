CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_dba_cross AS SELECT mandant_id,
 kjwo_update,
 matching_id,
 var_sst_tool_fg,
 var_w_tool_fg,
 var_n_tool_fg,
 var_ob_tool_fg,
 var_og_tool_fg,
 var_so_tool_fg,
 var_sw_tool_fg
FROM kfl_production_dbp_msi_data.dba_cross;