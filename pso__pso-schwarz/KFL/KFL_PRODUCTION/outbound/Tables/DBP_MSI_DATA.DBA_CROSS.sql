CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.dba_cross (
mandant_id BIGNUMERIC(38,0),
kjwo_update BIGNUMERIC(38,0),
matching_id BIGNUMERIC(38,0),
var_sst_tool_fg INTEGER,
var_w_tool_fg INTEGER,
var_n_tool_fg INTEGER,
var_ob_tool_fg INTEGER,
var_og_tool_fg INTEGER,
var_so_tool_fg INTEGER,
var_sw_tool_fg INTEGER,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY kjwo_update, matching_id;