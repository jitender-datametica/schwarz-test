CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_cost_element_group_lvl_4_1 (
ce_group_lvl4_nr STRING(20) NOT NULL OPTIONS(description='Unique identifier of the level 4 Cost Element Group'),
chart_of_accounts_cd STRING(5) NOT NULL OPTIONS(description='Unique Identifier of the Chart of Accounts'),
ce_group_lvl4_name_en STRING(100) OPTIONS(description='Name of the level 4 Cost Element Group in English'),
ce_group_lvl4_name_de STRING(100) OPTIONS(description='Name of the level 4 Cost Element Group in German'),
ce_group_lvl3_nr STRING(20) OPTIONS(description='Unique identifier of the  level 3 Cost Element Group'),
ce_group_lvl3_name_en STRING(100) OPTIONS(description='Name of the level 3 Cost Element Group in English'),
ce_group_lvl3_name_de STRING(100) OPTIONS(description='Name of the  level 3 Cost Element Group in German'),
ce_group_lvl2_nr STRING(20) OPTIONS(description='Unique identifier of the  level 2 Cost Element Group'),
ce_group_lvl2_name_en STRING(100) OPTIONS(description='Name of the level 2 Cost Element Group in English'),
ce_group_lvl2_name_de STRING(100) OPTIONS(description='Name of the  level 2 Cost Element Group in German'),
ce_group_lvl1_nr STRING(20) OPTIONS(description='Unique identifier of the  level 1 Cost Element Group'),
ce_group_lvl1_name_en STRING(100) OPTIONS(description='Name of the  level 1 Cost Element Group in English'),
ce_group_lvl1_name_de STRING(100) OPTIONS(description='Name of the  level 1 Cost Element Group in German'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (ce_group_lvl4_nr, chart_of_accounts_cd) NOT ENFORCED
) OPTIONS(description='Cost Element Groups - level 4 of the hierarchy_1');