CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_financial_account_1 (
fin_acct_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the Financial Account_1'),
acct_nr STRING(20)
OPTIONS(description='Number of the Account. The there are postings in the GL they are booked to this account_1 number'),
short_name_de STRING(100) OPTIONS(description='Short description of the Account_1 in German'),
long_name_de STRING(100) OPTIONS(description='Long description of the Account_1 in German'),
internal_company_sid BIGNUMERIC(38,0) OPTIONS(description='The unique identifier (surrogate key) for the company'),
internal_company_cd STRING(5)
OPTIONS(description='Unique identifier of the company to which we book accounting documents in the source system (SAP)'),
chart_of_accounts_cd STRING(5) OPTIONS(description='Unique Identifier of the Chart of Accounts'),
group_acct_nr STRING(20)
OPTIONS(description='For operative accounts ( Chart Of Accounts =\'LDI1\') this is the group account_1 they are asscoiated to. This facilitates reporting at group level'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (fin_acct_sid) NOT ENFORCED
) OPTIONS(description='Staging of accounts for core.t_dim_financial_accounts where no source system is available ');