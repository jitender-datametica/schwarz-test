/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_COST_CENTER_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 21. April 2022 10:44:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_cost_center_2 (
ctrl_area_cd STRING(5) NOT NULL OPTIONS(description='Code of the Controlling Area'),
cost_center_nr STRING(20) NOT NULL OPTIONS(description='Identifier of the Cost Center'),
cc_valid_from_dt DATE NOT NULL OPTIONS(description='The date from which this Cost Center can be used in bookings'),
cc_valid_to_dt DATE OPTIONS(description='The date till which this Cost Center can be used in bookings'),
internal_company_cd STRING(5) OPTIONS(description='In SAP this is the code that identifies a Lidl Company '),
curr_cd STRING(5) OPTIONS(description='The code according to ISO-4217 identifying the currency of the Cost Center.'),
short_name_en STRING(100) OPTIONS(description='Short description of the Cost Center in English'),
long_name_en STRING(100) OPTIONS(description='Long description of the Cost Center in English'),
short_name_de STRING(100) OPTIONS(description='Short description of the Cost Center in German'),
long_name_de STRING(100) OPTIONS(description='Long description of the Cost Center in Gernam'),
cc_group_lvl5_nr STRING(20)
OPTIONS(description='Unique identifier of the level 5 Cost Center Group (standard hierarchy_2)'),
cc_group_lvl5_name_en STRING(100)
OPTIONS(description='Name of the level 5 Cost Center Group in English (standard hierarchy_2)'),
cc_group_lvl5_name_de STRING(100)
OPTIONS(description='Name of the level 5 Cost Center Group in German (standard hierarchy_2)'),
cc_group_lvl4_nr STRING(20)
OPTIONS(description='Identifier of the Cost Center Group  to which this Cost Center belongs according to the Standard Hierarchy_2'),
cc_group_lvl4_name_en STRING(100)
OPTIONS(description='Name of the level 4 Cost Center Group in English (standart hierarchy_2)'),
cc_group_lvl4_name_de STRING(100)
OPTIONS(description='Name of the level 4 Cost Center Group in German (standart hierarchy_2)'),
cc_group_lvl3_nr STRING(20)
OPTIONS(description='Identifier of the Cost Center Group  to which the CC Group lvl 4 belongs according to the Standard Hierarchy_2'),
cc_group_lvl3_name_en STRING(100)
OPTIONS(description='Name of the level 3 Cost Center Group in English (standart hierarchy_2)'),
cc_group_lvl3_name_de STRING(100)
OPTIONS(description='Name of the level 3 Cost Center Group in German (standart hierarchy_2)'),
cc_group_lvl2_nr STRING(20)
OPTIONS(description='Identifier of the Cost Center Group  to which the CC Group lvl 3 belongs according to the Standard Hierarchy_2'),
cc_group_lvl2_name_en STRING(100)
OPTIONS(description='Name of the level 2 Cost Center Group in English (standart hierarchy_2)'),
cc_group_lvl2_name_de STRING(100)
OPTIONS(description='Name of the level 2 Cost Center Group in German (standart hierarchy_2)'),
cc_group_lvl1_nr STRING(20)
OPTIONS(description='Identifier of the Cost Center Group  to which the CC Group lvl 2 belongs according to the Standard Hierarchy_2'),
cc_group_lvl1_name_en STRING(100)
OPTIONS(description='Name of the level1 Cost Center Group in English (standart hierarchy_2)'),
cc_group_lvl1_name_de STRING(100)
OPTIONS(description='Name of the level1 Cost Center Group in German (standart hierarchy_2)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (ctrl_area_cd, cost_center_nr, cc_valid_from_dt) NOT ENFORCED
)
OPTIONS(description='The table contains one row for every combination of cost center and a controlling are             The cost centers describe "where a cost is spent - in which department/business area" ');