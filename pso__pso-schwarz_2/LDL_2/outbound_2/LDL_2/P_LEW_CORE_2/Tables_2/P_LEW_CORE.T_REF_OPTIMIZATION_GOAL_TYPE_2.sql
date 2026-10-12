CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_optimization_goal_type_2 (
opt_goal_type_cd STRING(100) NOT NULL OPTIONS(description='The code of the optimization goal.'),
opt_goal_type_descr STRING(250)
OPTIONS(description='Detailed description of the purpose of this optimization goal type.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run that inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Timestamp of the insertion of this row.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of this row.'),
PRIMARY KEY (opt_goal_type_cd) NOT ENFORCED
) OPTIONS(description='This reference table contains the possible types of optimization goals and their descriptions.');