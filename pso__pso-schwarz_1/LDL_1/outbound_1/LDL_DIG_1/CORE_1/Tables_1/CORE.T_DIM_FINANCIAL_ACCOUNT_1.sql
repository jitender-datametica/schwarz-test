/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_FINANCIAL_ACCOUNT_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 26. April 2022 16:59:01
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_financial_account_1 (
fin_acct_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the Financial Account_1'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became invalid'),
chart_of_accounts_cd STRING(5) NOT NULL OPTIONS(description='Unique Identifier of the Chart of Accounts'),
acct_nr STRING(20) NOT NULL
OPTIONS(description='Number of the Account. The there are postings in the GL they are booked to this account_1 number'),
internal_company_sid BIGNUMERIC NOT NULL OPTIONS(description='In SAP this is the code that identifies a Lidl Company '),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='A flat that shows (if TRUE) that the recotd is currently valid'),
group_acct_nr STRING(20)
OPTIONS(description='For operative accounts ( Chart Of Accounts =\'LDI1\') this is the group account_1 they are asscoiated to. This facilitates reporting at group level'),
balance_sheet_acct_fg BOOL OPTIONS(description='A flag that shows (if TRUE) that this is a balance sheet account_1'),
pl_statement_acct_fg BOOL
OPTIONS(description='A flag that shows (if TRUE) that this is a Profit and Loss statements account_1'),
reconciliation_acct_fg BOOL OPTIONS(description='A flag that shows (if TRUE) that this is a Reconciliation Account_1'),
cash_acct_fg BOOL
OPTIONS(description='A flag that shows (if TRUE) that this is a Cash receipt  / Cash disbursment account_1'),
curr_cd STRING(5) OPTIONS(description='The code according to ISO-4217 identifying the default currency of the account.'),
short_name_en STRING(100) OPTIONS(description='Short description of the Account_1 in English'),
long_name_en STRING(100) OPTIONS(description='Long description of the Account_1 in English'),
short_name_de STRING(100) OPTIONS(description='Short description of the Account_1 in German'),
long_name_de STRING(100) OPTIONS(description='Long description of the Account_1 in Gernam'),
src_sys_created_on DATE OPTIONS(description='A date when the record was created in the source system'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
internal_company_cd STRING(5)
OPTIONS(description='Unique identifier of the company to which we book accounting documents in the source system (SAP)'),
PRIMARY KEY (fin_acct_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='The table contains Financial Accounts and their associations with Lidl Companies.             The granularity is one row per combination of Chart of Accounts, Finnacial Account_1 ( Account_1 Number) and Lidl Company (Comapny Code).');