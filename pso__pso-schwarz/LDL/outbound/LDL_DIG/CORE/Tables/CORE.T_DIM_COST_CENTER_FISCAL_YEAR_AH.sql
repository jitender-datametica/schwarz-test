/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_COST_CENTER_FISCAL_YEAR_AH
   GENERATED FROM POWERDESIGNER ON Freitag, 10. Februar 2023 11:38:27
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_cost_center_fiscal_year_ah (
ctrl_area_cd STRING(5) NOT NULL OPTIONS(description='Code of the Controlling Area'),
cost_center_nr STRING(20) NOT NULL OPTIONS(description='Identifier of the Cost Center'),
fiscal_year BIGNUMERIC NOT NULL OPTIONS(description='A number that represents the fiscal year of the hierarchy'),
cc_group_lvl1_nr STRING(20) NOT NULL
OPTIONS(description='Identifier of the Cost Center Group Lvl 1 to which this Cost Center belongs in the selected business year hierarchy'),
cc_group_lvl1_name_en STRING(100) OPTIONS(description='Name of the level1 Cost Center Group in English'),
cc_group_lvl1_name_de STRING(100) OPTIONS(description='Name of the level1 Cost Center Group in German'),
cc_group_lvl2_nr STRING(20)
OPTIONS(description='Identifier of the Cost Center Group Lvl 2 to which this Cost Center belongs in the selected business year hierarchy'),
cc_group_lvl2_name_en STRING(100) OPTIONS(description='Name of the level 2 Cost Center Group in English'),
cc_group_lvl2_name_de STRING(100) OPTIONS(description='Name of the level 2 Cost Center Group in German'),
cc_group_lvl3_nr STRING(20)
OPTIONS(description='Identifier of the Cost Center Group Lvl 3 to which this Cost Center belongs in the selected business year hierarchy'),
cc_group_lvl3_name_en STRING(100) OPTIONS(description='Name of the level 3 Cost Center Group in English'),
cc_group_lvl3_name_de STRING(100) OPTIONS(description='Name of the level 3 Cost Center Group in German'),
cc_group_lvl4_nr STRING(20)
OPTIONS(description='Identifier of the Cost Center Group Lvl 4 to which this Cost Center belongs in the selected business year hierarchy'),
cc_group_lvl4_name_en STRING(100) OPTIONS(description='Name of the level 4 Cost Center Group in English'),
cc_group_lvl4_name_de STRING(100) OPTIONS(description='Name of the level 4 Cost Center Group in German'),
cc_group_lvl5_nr STRING(20)
OPTIONS(description='Identifier of the Cost Center Group Lvl 5 to which this Cost Center belongs in the selected business year hierarchy'),
cc_group_lvl5_name_en STRING(100) OPTIONS(description='Name of the level 5 Cost Center Group in English'),
cc_group_lvl5_name_de STRING(100) OPTIONS(description='Name of the level 5 Cost Center Group in German'),
cc_group_lvl6_nr STRING(20)
OPTIONS(description='Identifier of the Cost Center Group Lvl 6 to which this Cost Center belongs in the selected business year hierarchy'),
cc_group_lvl6_name_en STRING(100) OPTIONS(description='Name of the level 6 Cost Center Group in English'),
cc_group_lvl6_name_de STRING(100) OPTIONS(description='Name of the level 6 Cost Center Group in German'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (ctrl_area_cd, cost_center_nr, fiscal_year, cc_group_lvl1_nr) NOT ENFORCED
)
OPTIONS(description='Table that describes and historizes the fiscal year alternative hierarchies of Cost Center Groups and their relationship to Cost Center');