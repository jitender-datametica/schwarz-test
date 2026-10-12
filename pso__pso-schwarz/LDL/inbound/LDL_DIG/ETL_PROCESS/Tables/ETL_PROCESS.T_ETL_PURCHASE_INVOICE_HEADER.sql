/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_PURCHASE_INVOICE_HEADER
   GENERATED FROM POWERDESIGNER ON Dienstag, 29. November 2022 10:23:54
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_PURCHASE_INVOICE_HEADER (
   PURCH_INVOICE_NR                    VARCHAR(20)     NOT NULL COMMENT 'Invoice document number',
   FISCAL_YEAR                         NUMBER          NOT NULL COMMENT 'A number that represents the fiscal year for which the invoice document is posted',
   ACCT_DOC_TYPE_CD                    VARCHAR(5)      COMMENT 'Unique identifier of the document type',
   PURCH_INVOICE_DT                    DATE            COMMENT 'Invoice document date (when invoice was issued)',
   PURCH_INVOICE_POST_DT               DATE            COMMENT 'Invoice posting date (when invoice was registered in Financial system)',
   SUPPLIER_SID                        NUMBER          COMMENT 'The unique identifier (surrogate key) for supplier',
   SUPPLIER_NR                         VARCHAR(20)     COMMENT 'Account number of supplier/vendor from the sorce system',
   INTERNAL_COMPANY_SID                NUMBER          COMMENT 'The unique identifier (surrogate key) for the company',
   INTERNAL_COMPANY_CD                 VARCHAR(5)      COMMENT 'Unique identifier of the company to which we book accounting documents in the source system (SAP)',
   TAX_COUNTRY_CD                      VARCHAR(5)      COMMENT 'The unique code for a country according to ISO-3166 Alpha-2. E.g. \"DE\" for Germany or \"FR\" for France',
   CURR_CD                             VARCHAR(5)      COMMENT 'Currency code',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_PURCHASE_INVOICE_HEADER PRIMARY KEY (PURCH_INVOICE_NR, FISCAL_YEAR) NOT ENFORCED
 )  COMMENT= 'An ETL-support table that contains one row per purchase invoice header ( That is invoices issued by a supplier to a Lidl Purchasing company)';
