CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_optimization_goal_description (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The ID of the client (Lidl-Country).'),
opt_goal_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate key of the optimization goal.'),
opt_goal_descr STRING(250) OPTIONS(description='The country dependent description of the optimization goal.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run that inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Timestamp of the insertion of this row.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of this row.'),
PRIMARY KEY (opt_goal_sid, client_id) NOT ENFORCED
) OPTIONS(description='This reference table contains country specific descriptions of optimization goals.');