CREATE TABLE IF NOT EXISTS ldl_fe_mstr_xsight.t_tech_steering_kpi_1 (
dashboard STRING(100),
group_id BIGNUMERIC(38,0),
group_name STRING(100100),
group_name_en STRING(100100),
subgroup_id BIGNUMERIC(38,0),
subgroup_name STRING(100),
kpi_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) of the KPI.'),
kpi_name STRING(100),
kpi_desc STRING(100),
kpi_name_de STRING(100),
kpi_name_en STRING(100)
);