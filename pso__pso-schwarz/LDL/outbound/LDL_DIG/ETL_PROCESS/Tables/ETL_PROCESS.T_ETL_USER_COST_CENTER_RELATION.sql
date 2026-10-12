/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_USER_COST_CENTER_RELATION
   GENERATED FROM POWERDESIGNER ON Montag, 13. März 2023 11:29:43
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_user_cost_center_relation (
username STRING(50)
OPTIONS(description='Username of the user (Lidl Digital employee)            Username of the user (Lidl Digital employee)'),
full_mstr_login_name STRING(100) NOT NULL OPTIONS(description='Microstrategy login of the user (Lidl Digital employee)'),
fiscal_year BIGNUMERIC(38,0) NOT NULL OPTIONS(description='A number that represents the fiscal year of the hierarchy'),
cc_group_security_lvl STRING(20) NOT NULL
OPTIONS(description='Identifier of the Cost Center Group to which the user has access to'),
cc_group_lvl1_nr STRING(20)
OPTIONS(description='Identifier of the Cost Center Group Lvl 1 to which this Cost Center belongs in the selected business year hierarchy'),
cc_group_lvl2_nr STRING(20)
OPTIONS(description='Identifier of the Cost Center Group Lvl 2 to which this Cost Center belongs in the selected business year hierarchy'),
cc_group_lvl3_nr STRING(20)
OPTIONS(description='Identifier of the Cost Center Group Lvl 3 to which this Cost Center belongs in the selected business year hierarchy'),
cc_group_lvl4_nr STRING(20)
OPTIONS(description='Identifier of the Cost Center Group Lvl 4 to which this Cost Center belongs in the selected business year hierarchy'),
cc_group_lvl5_nr STRING(20)
OPTIONS(description='Identifier of the Cost Center Group Lvl 5 to which this Cost Center belongs in the selected business year hierarchy'),
cc_group_lvl6_nr STRING(20)
OPTIONS(description='Identifier of the Cost Center Group Lvl 6 to which this Cost Center belongs in the selected business year hierarchy'),
cost_center_nr STRING(20) OPTIONS(description='Identifier of the Cost Center'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (full_mstr_login_name, fiscal_year, cc_group_security_lvl) NOT ENFORCED
)
OPTIONS(description='This table contains users information and the highest level cost_center_group to which they have access to.');