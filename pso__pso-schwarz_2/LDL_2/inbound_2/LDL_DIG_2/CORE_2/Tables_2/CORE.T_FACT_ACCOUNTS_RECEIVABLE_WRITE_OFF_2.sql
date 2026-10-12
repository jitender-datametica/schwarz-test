/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_ACCOUNTS_RECEIVABLE_WRITE_OFF_2
   GENERATED FROM POWERDESIGNER ON Montag, 18. November 2024 16:37:36
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_ACCOUNTS_RECEIVABLE_WRITE_OFF_2 (
   ACCT_WRITE_OFF_DOC_NR               VARCHAR(20)     NOT NULL COMMENT 'The unique identifier for the contract account_2 write-off document in the source system (SAP). There can be multiple write-off documents for the same accounts receivable: there can be one write-off for the whole accounts receivable, or only for a part of it (position level, or position part, etc.)',
   ACCT_RECEIVABLE_DOC_NR              VARCHAR(20)     NOT NULL COMMENT 'The unique identifier for the contract accounts receivable document in the source system (SAP).',
   ACCT_RECEIVABLE_DOC_POS_NR          VARCHAR(20)     NOT NULL COMMENT 'The position number within the contract accounts receivable document in the source system (SAP).',
   ACCT_RECEIVABLE_DOC_PART_POS_NR     VARCHAR(20)     NOT NULL COMMENT 'In case the total amount for the accounts receivable is split into multiple parts, this is the number of the given part.',
   ACCT_RECEIVABLE_DOC_PART_POS_SEQ_NR VARCHAR(20)     NOT NULL COMMENT 'In case the total amount for the accounts receivable is split into multiple parts, which are planned as repeated payments, this is the given sequence number for the payment.',
   INTERNAL_COMPANY_SID                NUMBER          COMMENT 'The unique identifier (surrogate key) for the company',
   INTERNAL_COMPANY_CD                 VARCHAR(5)      COMMENT 'The unique identifier of the company to which accounting documents are booked in the source system (SAP).',
   CUST_SID                            NUMBER          COMMENT 'The unique identifier (surrogate key) for the customer in SAP. The customer can be a person (e.g. online shop customer) or a legal entity (e.g. internal or external company).',
   CUST_NR                             VARCHAR(20)     COMMENT 'The unique identifier for the customer in SAP. The customer can be a person (e.g. online shop customer) or a legal entity (e.g. internal or external company).',
   CONTRACT_ACCT_NR                    VARCHAR(20)     COMMENT 'The unique identifier of the contract account_2 associated with the accounts receivable asset. The contract account_2 is used for very granular assignment of financial transactions. A contract account_2 can be used for multiple contracts but is always assigned to a unique customer. There can be several contract accounts for a single customer (example use-case: if the customer is using a standard payment transfer method but also Lidl Pay, there are two contract accounts)',
   CURR_CD                             VARCHAR(5)      COMMENT 'The code identifying the currency according to ISO-4217.',
   WRITE_OFF_GROSS_LOCAL_VAL           NUMBER(38, 5)   COMMENT 'The accounts receivable gross amount which is being written off - in local currency.',
   WRITE_OFF_REASON_CD                 VARCHAR(5)      COMMENT 'Code for the reason of the write-off operation.',
   WRITE_OFF_DT                        DATE            COMMENT 'The date of the accounts receivable write-off operation.',
   ACCT_DOC_TYPE_CD                    VARCHAR(5)      COMMENT 'Code for the accounting document type.',
   IS_WRITE_OFF_REVERSED_FG            BOOLEAN         COMMENT 'A write-off operation can be reversed (= basically cancelled), which means that there can be multiple write-off documents for the exact same accounts receivable amount in case of reversed operations (cause can be re_2-categorizations, corrections, mistakes, etc.). This flag helps identify which is the valid operation to consider.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_FACT_ACCOUNTS_RECEIVABLE_WRITE_OFF PRIMARY KEY (ACCT_WRITE_OFF_DOC_NR, ACCT_RECEIVABLE_DOC_NR, ACCT_RECEIVABLE_DOC_POS_NR, ACCT_RECEIVABLE_DOC_PART_POS_NR, ACCT_RECEIVABLE_DOC_PART_POS_SEQ_NR) NOT ENFORCED 
)  COMMENT = 'This fact table contains data about write-off accounting operations performed on accounts receivable. Accounts receivable is an accounting term for money owed to a business for goods or services that it has delivered but not been paid for yet. Accounts receivable is listed on the company''s balance sheet as a current asset. A write-off is an elimination of an uncollectible accounts receivable recorded on the general ledger. This table is unrelated to  t_dim_financial_account_2 as the latter contains information about high-level accounting accounts used for financial reporting (relevant for the balance sheet).';
