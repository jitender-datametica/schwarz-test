CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_optimization_goal_1 (
opt_goal_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate key of the optimization goal.'),
opt_goal_type_cd STRING(100) NOT NULL
OPTIONS(description='The code of the optimization goal (reference to t_ref_optimization_goal_type_1).'),
opt_goal_value BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The value of the optimization goal dependent on the type.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run that inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Timestamp of the insertion of this row.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of this row.'),
PRIMARY KEY (opt_goal_sid) NOT ENFORCED
) OPTIONS(description='This reference table contains the possible optimization goals.');