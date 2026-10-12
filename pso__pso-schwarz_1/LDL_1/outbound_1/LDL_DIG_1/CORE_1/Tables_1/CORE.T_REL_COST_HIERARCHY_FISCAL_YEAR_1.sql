/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REL_COST_HIERARCHY_FISCAL_YEAR_1
   GENERATED FROM POWERDESIGNER ON Freitag, 10. Februar 2023 11:37:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_rel_cost_hierarchy_fiscal_year_1 (
fiscal_year BIGNUMERIC(38,0) NOT NULL OPTIONS(description='A number that represents the fiscal year of the hierarchy_1'),
ctrl_area_cd STRING(5) OPTIONS(description='Code of the Controlling Area'),
cc_group_lvl1_nr STRING(20) OPTIONS(description='Unique identifier of the level1 Cost Center Group'),
chart_of_accounts_cd STRING(5) OPTIONS(description='Unique Identifier of the Chart of Accounts'),
ce_group_lvl1_nr STRING(20) OPTIONS(description='U nique identifier of the  level 1 Cost Element Group'),
ce_group_lvl2_nr STRING(20) OPTIONS(description='U nique identifier of the  level 2 Cost Element Group'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (fiscal_year) NOT ENFORCED
)
OPTIONS(description='Table that contains per each fiscal year the highest hierarchies level per cost centers and cost elements, to identify which hierarchy_1 is used in each fiscal year');