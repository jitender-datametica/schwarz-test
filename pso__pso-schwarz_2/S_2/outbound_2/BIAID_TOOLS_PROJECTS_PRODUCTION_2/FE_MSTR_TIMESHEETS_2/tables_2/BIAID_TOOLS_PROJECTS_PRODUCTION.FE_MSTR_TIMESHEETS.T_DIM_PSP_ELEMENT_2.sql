CREATE OR REPLACE TABLE biaid_tools_projects_production_fe_mstr_timesheets.t_dim_psp_element_2 (
psp_element_cd STRING(50) NOT NULL OPTIONS(description='Unique code of the PSP elemenent'),
psp_element_short_name STRING(200) OPTIONS(description='Name of the PSP Element'),
psp_element_long_name STRING(300)
OPTIONS(description='Display name of the PSP Element as shown in IT4YOY (name +\"[KFL-INTEGER ]\"/\'[LDL-INTEGER ]\' ... )'),
psp_element_status_name STRING(20)
OPTIONS(description='Status_2 of the PSP Element ( ex Active, Retired, Work in Progress)'),
solution_type_name STRING(20) OPTIONS(description='Type indicating if this is\"IT-Solution\" or\"Business Solution\"'),
solution_expert_full_name STRING(100)
OPTIONS(description='Full Name (First + Last name ) of the Solution Expert of this PSP element'),
solution_owner_full_name STRING(100)
OPTIONS(description='Full Name (First + Last name ) of the Solution Owner of this PSP element'),
psp_operations_nr STRING(20) OPTIONS(description='Number associated with all operations related to this PSP element'),
psp_requirements_nr STRING(20)
OPTIONS(description='Number associated with all requirements related to this PSP element'),
PRIMARY KEY (psp_element_cd) NOT ENFORCED
) OPTIONS(description='Dimension that contains unique PSP emenents and their descriptions');