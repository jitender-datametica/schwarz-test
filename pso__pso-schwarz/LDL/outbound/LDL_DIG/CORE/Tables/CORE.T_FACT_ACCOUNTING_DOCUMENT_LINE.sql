/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_ACCOUNTING_DOCUMENT_LINE
   GENERATED FROM POWERDESIGNER ON Dienstag, 9. August 2022 12:17:22
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_accounting_document_line (
ledger_cd STRING(5) NOT NULL OPTIONS(description='A code that idenfies the Ledger to which the document is posted'),
internal_company_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the company for which the posting is made'),
fiscal_year BIGNUMERIC NOT NULL
OPTIONS(description='A number that represents the fiscal year for which the accounting document is posted'),
acct_doc_nr STRING(20) NOT NULL
OPTIONS(description='Number of the Accounting Document. It is unique only within a CompanyCode, Financial Year and Ledger'),
acct_doc_line_nr STRING(20) NOT NULL
OPTIONS(description='six-character-formatted posting item number within the document (line nuber)'),
internal_company_cd STRING(5) OPTIONS(description='Unique identifier of the company in the source system (SAP)'),
fin_acct_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the Financial Account'),
internal_company_partner_sid BIGNUMERIC
OPTIONS(description='The unique identifier (surrogate key) of the internal company partner - receiving or sending other company, e.g. in the context of an Inter Company billing'),
internal_company_partner_nr STRING(20)
OPTIONS(description='Unique number of the partner company (receiving or sending company)'),
acct_nr STRING(20)
OPTIONS(description='Number of the account to which the posting is made. Same as Cost Element Number for records that are extedned with controlling information.'),
acct_doc_dt DATE OPTIONS(description='Accounting Document Date (in the document itself) '),
acct_doc_type_cd STRING(5) OPTIONS(description='Code of the type of the Accounting Document'),
acct_doc_posting_dt DATE OPTIONS(description='Date when the posting in the Leger is made'),
acct_doc_status STRING(5)
OPTIONS(description='Code that represents the status of the document. Empty is regular posting. C is balance carry-forwards. U means posting in GL only,'),
ctrl_doc_nr STRING(20)
OPTIONS(description='Number of the Controlling document associated with this accounting document line'),
fiscal_period_nr BIGNUMERIC
OPTIONS(description='Number of the fiscal period within a fiscal year.. Note some fiscal years may contain more that 12 periods'),
curr_cd STRING(5)
OPTIONS(description='The code of the currency that is default for this company according to ISO-4217.'),
posting_local_val BIGNUMERIC(38,5)
OPTIONS(description='Value of posting in local currency (local for the company for which the posting is made)'),
posting_group_val BIGNUMERIC(38,5) OPTIONS(description='Value of posting in group currency.'),
ctrl_area_cd STRING(5) OPTIONS(description='Code of the Controlling Area'),
cost_center_nr STRING(20) OPTIONS(description='Identifier of the Cost Center for which this posting is booked'),
sender_cost_center_nr STRING(20)
OPTIONS(description='For postings that represent  a redistribution of cost based on a specific rule this is the code of the Cost Center where the origianal posting was made'),
posting_tmsp TIMESTAMP OPTIONS(description='Timestamp in UTC when the posting was made'),
ref_doc_nr STRING(20)
OPTIONS(description='Identifier of the "real world (original) document" (like logistic document) that is the reason for which we have accounting document(s)'),
accounted_module_cd STRING(5)
OPTIONS(description='Code of the module from which the "real world document" originated (Material/Shipping ..)'),
debit_credit_cd STRING(5)
OPTIONS(description='Value indicating if the current row represents debit (value\'S\') or credit (value\'H\')'),
offsetting_acct_nr STRING(20)
OPTIONS(description='Number of the offsetting (Contra) account of the account of the posting'),
gl_acct_type STRING(5) OPTIONS(description='Type of the General Ledger Account ( P = Profit and Loss account)'),
acct_document_tx STRING(1000) OPTIONS(description='Text of the accounting document '),
acct_trans_type_cd STRING(20) OPTIONS(description='Unique identifier of the accounting transaction type'),
acct_cost_type_cd STRING(20) OPTIONS(description='Unique identifier of the cost type'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
prod_variant_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
chart_of_accounts_cd STRING(5) OPTIONS(description='Unique Identifier of the Chart of Accounts'),
PRIMARY KEY (ledger_cd, internal_company_sid, fiscal_year, acct_doc_nr, acct_doc_line_nr) NOT ENFORCED
)
OPTIONS(description='The table contains one line for every accounting document line item, multiplied by the number of ledgers (in case Accounting Document is posted in more than one ledger).             The line items are extened with additional attributes that carry the information relevant for Financial Controlling.             The buisness key is formed by Ledger, Company Code, Fiscal  Year, Document Number, Document Line Number');