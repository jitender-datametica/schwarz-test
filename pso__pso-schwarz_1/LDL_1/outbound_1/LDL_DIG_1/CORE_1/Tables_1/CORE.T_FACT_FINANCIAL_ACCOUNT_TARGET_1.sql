/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_FINANCIAL_ACCOUNT_TARGET_1
   GENERATED FROM POWERDESIGNER ON Mittwoch, 18. Mai 2022 08:11:56
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_financial_account_target_1 (
fiscal_year BIGNUMERIC NOT NULL
OPTIONS(description='A number that represents the fiscal year for which the accounting document is posted'),
fiscal_period BIGNUMERIC NOT NULL
OPTIONS(description='Number of the fiscal period within a fiscal year.. Note some fiscal years may contain more that 12 periods'),
cost_center_nr STRING(20) NOT NULL OPTIONS(description='Identifier of the Cost Center'),
acct_nr STRING(20) NOT NULL
OPTIONS(description='Number of the Account. The there are postings in the GL they are booked to this account_1 number'),
internal_company_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the company'),
ctrl_area_cd STRING(5) NOT NULL OPTIONS(description='Code of the Controlling Area'),
posting_dt DATE OPTIONS(description='The date when the posting was made'),
posting_group_tgt_net_eur_val BIGNUMERIC(38,5) OPTIONS(description='The planned value of the posting group'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
internal_company_cd STRING(5)
OPTIONS(description='Unique identifier of the company to which we book accounting documents in the source system (SAP)'),
PRIMARY KEY (fiscal_year, fiscal_period, cost_center_nr, acct_nr, internal_company_sid, ctrl_area_cd) NOT ENFORCED
) OPTIONS(description='The snapshot_1 fact holds the KER account_1 target plan values at the fiscal year and period level');