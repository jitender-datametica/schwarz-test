/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_ACCOUNTING_DOCUMENT_LINE_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 9. August 2022 12:17:22
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_ACCOUNTING_DOCUMENT_LINE_2 (
   LEDGER_CD                           VARCHAR(5)      NOT NULL COMMENT 'A code that idenfies the Ledger to which the document is posted',
   INTERNAL_COMPANY_SID                NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the company for which the posting is made',
   FISCAL_YEAR                         NUMBER          NOT NULL COMMENT 'A number that represents the fiscal year for which the accounting document is posted',
   ACCT_DOC_NR                         VARCHAR(20)     NOT NULL COMMENT 'Number of the Accounting Document. It is unique only within a CompanyCode, Financial Year and Ledger',
   ACCT_DOC_LINE_NR                    VARCHAR(20)     NOT NULL COMMENT 'six-character-formatted posting item_2 number within the document (line nuber)',
   INTERNAL_COMPANY_CD                 VARCHAR(5)      COMMENT 'Unique identifier of the company in the source system (SAP)',
   FIN_ACCT_SID                        NUMBER          COMMENT 'The unique identifier (surrogate key) for the Financial Account_2',
   INTERNAL_COMPANY_PARTNER_SID        NUMBER          COMMENT 'The unique identifier (surrogate key) of the internal company partner - receiving or sending other company, e.g. in the context of an Inter Company billing',
   INTERNAL_COMPANY_PARTNER_NR         VARCHAR(20)     COMMENT 'Unique number of the partner company (receiving or sending company)',
   ACCT_NR                             VARCHAR(20)     COMMENT 'Number of the account_2 to which the posting is made. Same as Cost Element Number for records that are extedned with controlling information.',
   ACCT_DOC_DT                         DATE            COMMENT 'Accounting Document Date (in the document itself) ',
   ACCT_DOC_TYPE_CD                    VARCHAR(5)      COMMENT 'Code of the type of the Accounting Document',
   ACCT_DOC_POSTING_DT                 DATE            COMMENT 'Date when the posting in the Leger is made',
   ACCT_DOC_STATUS                     VARCHAR(5)      COMMENT 'Code that represents the status_2 of the document. Empty is regular posting. C is balance carry-forwards. U means posting in GL only,',
   CTRL_DOC_NR                         VARCHAR(20)     COMMENT 'Number of the Controlling document associated with this accounting document line',
   FISCAL_PERIOD_NR                    NUMBER          COMMENT 'Number of the fiscal period within a fiscal year.. Note some fiscal years may contain more that 12 periods',
   CURR_CD                             VARCHAR(5)      COMMENT 'The code of the currency that is default for this company according to ISO-4217.',
   POSTING_LOCAL_VAL                   NUMBER(38, 5)   COMMENT 'Value of posting in local currency (local for the company for which the posting is made)',
   POSTING_GROUP_VAL                   NUMBER(38, 5)   COMMENT 'Value of posting in group currency.',
   CTRL_AREA_CD                        VARCHAR(5)      COMMENT 'Code of the Controlling Area',
   COST_CENTER_NR                      VARCHAR(20)     COMMENT 'Identifier of the Cost Center for which this posting is booked',
   SENDER_COST_CENTER_NR               VARCHAR(20)     COMMENT 'For postings that represent  a redistribution of cost based on a specific rule this is the code of the Cost Center where the origianal posting was made',
   POSTING_TMSP                        TIMESTAMP_TZ(9) COMMENT 'Timestamp in UTC when the posting was made',
   REF_DOC_NR                          VARCHAR(20)     COMMENT 'Identifier of the "real world (original) document" (like logistic document) that is the reason for which we have accounting document(s)',
   ACCOUNTED_MODULE_CD                 VARCHAR(5)      COMMENT 'Code of the module from which the "real world document" originated (Material/Shipping ..)',
   DEBIT_CREDIT_CD                     VARCHAR(5)      COMMENT 'Value indicating if the current row represents debit (value ''S'') or credit (value ''H'')',
   OFFSETTING_ACCT_NR                  VARCHAR(20)     COMMENT 'Number of the offsetting (Contra) account_2 of the account_2 of the posting',
   GL_ACCT_TYPE                        VARCHAR(5)      COMMENT 'Type of the General Ledger Account_2 ( P = Profit and Loss account_2)',
   ACCT_DOCUMENT_TX                    VARCHAR(1000)   COMMENT 'Text of the accounting document ',
   ACCT_TRANS_TYPE_CD                  VARCHAR(20)     COMMENT 'Unique identifier of the accounting transaction type',
   ACCT_COST_TYPE_CD                   VARCHAR(20)     COMMENT 'Unique identifier of the cost type',
   PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The product variant number',
   PROD_VARIANT_SID                    NUMBER          COMMENT 'The unique identifier (surrogate key) for the product variant',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CHART_OF_ACCOUNTS_CD                VARCHAR(5)      COMMENT 'Unique Identifier of the Chart of Accounts',
   CONSTRAINT PK_T_FACT_ACCOUNTING_DOCUMENT_LINE PRIMARY KEY (LEDGER_CD, INTERNAL_COMPANY_SID, FISCAL_YEAR, ACCT_DOC_NR, ACCT_DOC_LINE_NR) NOT ENFORCED
 )  COMMENT= 'The table contains one line for every accounting document line item_2, multiplied by the number of ledgers (in case Accounting Document is posted in more than one ledger).
             The line items are extened with additional attributes that carry the information relevant for Financial Controlling.
             The buisness key is formed by Ledger, Company Code, Fiscal  Year, Document Number, Document Line Number';
