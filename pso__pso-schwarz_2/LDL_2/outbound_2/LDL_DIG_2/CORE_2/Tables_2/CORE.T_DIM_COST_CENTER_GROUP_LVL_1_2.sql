/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_COST_CENTER_GROUP_LVL_1_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 12. April 2022 14:32:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_cost_center_group_lvl_1_2 (
cc_group_lvl1_nr STRING(20) NOT NULL OPTIONS(description='U nique identifier of the level1 Cost Center Group'),
ctrl_area_cd STRING(5) NOT NULL OPTIONS(description='Code of the Controlling Area'),
cc_group_lvl1_name_en STRING(100) OPTIONS(description='Name of the level1 Cost Center Group in English'),
cc_group_lvl1_name_de STRING(100) OPTIONS(description='Name of the level1 Cost Center Group in German'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cc_group_lvl1_nr, ctrl_area_cd) NOT ENFORCED
) OPTIONS(description='Highest level of hierarchy_2 for Cost Center Groups');