/* --------------------------------------------------------------------------------
   DDL FOR TABLE: CORE.T_DIM_CHART_OF_ACCOUNTS_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 3. Februar 2022 15:41:59
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_chart_of_accounts_2 (
chart_of_accounts_cd STRING(5) NOT NULL OPTIONS(description='Unique Identifier of the Chart of Accounts'),
chart_of_acct_name_en STRING(100) OPTIONS(description='Name of the ledger in English'),
chart_of_acct_name_de STRING(100) OPTIONS(description='Name of the ledger in German'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (chart_of_accounts_cd) NOT ENFORCED
) OPTIONS(description='A minor dimensiont that contains all Chart of Accounts used by Lidl Companies');