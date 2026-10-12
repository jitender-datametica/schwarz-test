CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_cost_element_fiscal_year_ah_1 (
acct_nr STRING(20) NOT NULL
OPTIONS(description='Cost element Number. Same as the Account_1 Number of the corresponding Profit and Loss Account_1'),
ctrl_area_cd STRING(5) NOT NULL OPTIONS(description='Code of the Controlling Area '),
fiscal_year BIGNUMERIC NOT NULL
OPTIONS(description='A number that represents the fiscal year for which the accounting document is posted'),
ce_group_lvl1_nr STRING(20) NOT NULL
OPTIONS(description='Identifier of the Cost Element Group (a.k.a. KER Position) to which the CE Group lvl2 belongs according to the Standard  Hierarchy_1'),
ce_group_lvl1_name_en STRING(100) OPTIONS(description='Long description of the  level 1 Cost Element Group in English'),
ce_group_lvl1_name_de STRING(100) OPTIONS(description='Short description of the  level 1 Cost Element Group in German'),
ce_group_lvl2_nr STRING(20)
OPTIONS(description='Identifier of the Cost Element Group (a.k.a. KER Position) to which the CE Group lvl3 belongs according to the Standard  Hierarchy_1'),
ce_group_lvl2_name_en STRING(100) OPTIONS(description='Long description of the level 2 Cost Element Group in English'),
ce_group_lvl2_name_de STRING(100) OPTIONS(description='Short description of the  level 2 Cost Element Group in German'),
ce_group_lvl3_nr STRING(20)
OPTIONS(description='Identifier of the Cost Element Group (a.k.a. KER Position) to which this Cost Element belongs according to the Standard  Hierarchy_1'),
ce_group_lvl3_name_en STRING(100) OPTIONS(description='Long description of the level 3 Cost Element Group in English'),
ce_group_lvl3_name_de STRING(100) OPTIONS(description='Short description of the  level 3 Cost Element Group in German'),
ce_group_lvl4_nr STRING(20)
OPTIONS(description='Identifier of the Cost Element Group level 4 (a.k.a. KER Position) to which this Cost Element belongs according to the Standard  Hierarchy_1'),
ce_group_lvl4_name_en STRING(100) OPTIONS(description='Long description of the level 4 Cost Element Group in English'),
ce_group_lvl4_name_de STRING(100) OPTIONS(description='Short description of the  level 4 Cost Element Group in German'),
chart_of_accounts_cd STRING(5) OPTIONS(description='Unique Identifier of the Chart of Accounts'),
short_name_en STRING(100) OPTIONS(description='Short description of the Cost Element in English'),
long_name_en STRING(100) OPTIONS(description='Long description of the Cost Element in English'),
short_name_de STRING(100) OPTIONS(description='Short description of the Cost Element in German'),
long_name_de STRING(100) OPTIONS(description='Long description of the Cost Element in Gernam'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (ctrl_area_cd, acct_nr, fiscal_year, ce_group_lvl1_nr) NOT ENFORCED
)
OPTIONS(description='Table that describes and historizes the fiscal year alternative hierarchies of Cost Element Groups and their relationship to Cost Element');