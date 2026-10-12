/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_COST_ELEMENT
   GENERATED FROM POWERDESIGNER ON Montag, 27. Februar 2023 10:05:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_cost_element (
acct_nr STRING(20) NOT NULL
OPTIONS(description='Cost element Number. Same as the Account Number of the corresponding Profit and Loss Account'),
ctrl_area_cd STRING(5) OPTIONS(description='Code of the Controlling Area '),
ce_valid_from_dt DATE OPTIONS(description='The start date when this cost element can be used in booking'),
ce_valid_to_dt DATE OPTIONS(description='The end date when this cost element can be used in booking'),
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
PRIMARY KEY (acct_nr) NOT ENFORCED
)
OPTIONS(description='An ETL table that helps populating T_DIM_COST_ELEMENT             The table contains one row per combination of Cost Element and Controlling Area. One cost element is created for every Financial Account of type Profit and Loss Account.             Cost Element Number is equal to Account Number');