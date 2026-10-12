/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_FINANCIAL_PERIOD_SUMMARY_1
   GENERATED FROM POWERDESIGNER ON Freitag, 20. Mai 2022 07:22:10
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_financial_period_summary_1 (
fiscal_year BIGNUMERIC NOT NULL
OPTIONS(description='A number that represents the fiscal year for which the accounting document is posted'),
fiscal_period BIGNUMERIC NOT NULL
OPTIONS(description='Number of the fiscal period within a fiscal year.. Note some fiscal years may contain more that 12 periods'),
cost_center_nr STRING(20) NOT NULL OPTIONS(description='Identifier of the Cost Center'),
acct_nr STRING(20) NOT NULL
OPTIONS(description='Number of the Account. The there are postings in the GL they are booked to this account_1 number'),
internal_company_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the company'),
ctrl_area_cd STRING(5) NOT NULL OPTIONS(description='Code of the Controlling Area'),
acct_data_src_name STRING(20) NOT NULL OPTIONS(description='Name  of the source of the aggregated data'),
posting_dt DATE OPTIONS(description='The date when the posting was made'),
total_amount_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='The aggregated amount of all transactions for the fiscal period booked to the given cost center, company and account_1 number'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (fiscal_year, fiscal_period, cost_center_nr, acct_nr, internal_company_sid, ctrl_area_cd, acct_data_src_name
 ) NOT ENFORCED
)
OPTIONS(description='A table that helps the ETL process of populating T_AGG_FINANCIAL_PERIOD_SUMMARY. Contains aggregated data for a fiscal period for achieved results at company, cost_center and account_1 (cost element) level');