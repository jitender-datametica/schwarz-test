CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_ref_parameter_vt (
param_id INTEGER OPTIONS(description='Parameter ID'),
client_id INTEGER OPTIONS(description='Client ID to which the parameter should be applied. 7 = All'),
val_int INTEGER OPTIONS(description='Integer parameter value'),
val_date DATE OPTIONS(description='Date parameter value'),
val_varchar STRING(10) OPTIONS(description='STRING parameter value'),
comments STRING(100) OPTIONS(description='Description of paramater and value')
) OPTIONS(description='Parameter Table for Reporting Team Solution VT');