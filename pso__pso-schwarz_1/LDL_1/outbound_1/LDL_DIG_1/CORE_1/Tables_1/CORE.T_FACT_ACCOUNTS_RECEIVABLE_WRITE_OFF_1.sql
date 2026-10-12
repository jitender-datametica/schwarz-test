/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_ACCOUNTS_RECEIVABLE_WRITE_OFF_1
   GENERATED FROM POWERDESIGNER ON Montag, 18. November 2024 16:37:36
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_accounts_receivable_write_off_1 (
acct_write_off_doc_nr STRING(20) NOT NULL
OPTIONS(description='The unique identifier for the contract account_1 write-off document in the source system (SAP). There can be multiple write-off documents for the same accounts receivable: there can be one write-off for the whole accounts receivable, or only for a part of it (position level, or position part, etc.)'),
acct_receivable_doc_nr STRING(20) NOT NULL
OPTIONS(description='The unique identifier for the contract accounts receivable document in the source system (SAP).'),
acct_receivable_doc_pos_nr STRING(20) NOT NULL
OPTIONS(description='The position number within the contract accounts receivable document in the source system (SAP).'),
acct_receivable_doc_part_pos_nr STRING(20) NOT NULL
OPTIONS(description='In case the total amount for the accounts receivable is split into multiple parts, this is the number of the given part.'),
acct_receivable_doc_part_pos_seq_nr STRING(20) NOT NULL
OPTIONS(description='In case the total amount for the accounts receivable is split into multiple parts, which are planned as repeated payments, this is the given sequence number for the payment.'),
internal_company_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the company'),
internal_company_cd STRING(5)
OPTIONS(description='The unique identifier of the company to which accounting documents are booked in the source system (SAP).'),
cust_sid BIGNUMERIC
OPTIONS(description='The unique identifier (surrogate key) for the customer in SAP. The customer can be a person (e.g. online shop customer) or a legal entity (e.g. internal or external company).'),
cust_nr STRING(20)
OPTIONS(description='The unique identifier for the customer in SAP. The customer can be a person (e.g. online shop customer) or a legal entity (e.g. internal or external company).'),
contract_acct_nr STRING(20)
OPTIONS(description='The unique identifier of the contract account_1 associated with the accounts receivable asset. The contract account_1 is used for very granular assignment of financial transactions. A contract account_1 can be used for multiple contracts but is always assigned to a unique customer. There can be several contract accounts for a single customer (example use-case: if the customer is using a standard payment transfer method but also Lidl Pay, there are two contract accounts)'),
curr_cd STRING(5) OPTIONS(description='The code identifying the currency according to ISO-4217.'),
write_off_gross_local_val BIGNUMERIC(38,5)
OPTIONS(description='The accounts receivable gross amount which is being written off - in local currency.'),
write_off_reason_cd STRING(5) OPTIONS(description='Code for the reason of the write-off operation.'),
write_off_dt DATE OPTIONS(description='The date of the accounts receivable write-off operation.'),
acct_doc_type_cd STRING(5) OPTIONS(description='Code for the accounting document type.'),
is_write_off_reversed_fg BOOL
OPTIONS(description='A write-off operation can be reversed (= basically cancelled), which means that there can be multiple write-off documents for the exact same accounts receivable amount in case of reversed operations (cause can be re_1-categorizations, corrections, mistakes, etc.). This flag helps identify which is the valid operation to consider.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (acct_write_off_doc_nr, acct_receivable_doc_nr, acct_receivable_doc_pos_nr, acct_receivable_doc_part_pos_nr
 , acct_receivable_doc_part_pos_seq_nr) NOT ENFORCED
)
OPTIONS(description='This fact table contains data about write-off accounting operations performed on accounts receivable. Accounts receivable is an accounting term for money owed to a business for goods or services that it has delivered but not been paid for yet. Accounts receivable is listed on the company\'s balance sheet as a current asset. A write-off is an elimination of an uncollectible accounts receivable recorded on the general ledger. This table is unrelated to  t_dim_financial_account_1 as the latter contains information about high-level accounting accounts used for financial reporting (relevant for the balance sheet).');