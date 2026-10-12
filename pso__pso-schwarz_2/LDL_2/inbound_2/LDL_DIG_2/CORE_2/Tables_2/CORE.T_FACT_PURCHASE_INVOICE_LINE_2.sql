/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_PURCHASE_INVOICE_LINE_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 29. November 2022 10:24:12
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_PURCHASE_INVOICE_LINE_2 (
   PURCH_INVOICE_NR                    VARCHAR(20)     NOT NULL COMMENT 'Invoice document number',
   PURCH_INVOICE_POS_NR                NUMBER          NOT NULL COMMENT ' Identifier of item_2/position/line within invoice. An invoice can have many lines. For each invoice line numbers start with 1',
   FISCAL_YEAR                         NUMBER          NOT NULL COMMENT 'A number that represents the fiscal year for which the invoice document is posted',
   ACCT_DOC_TYPE_CD                    VARCHAR(5)      COMMENT 'Unique identifier of the document type',
   PURCH_INVOICE_DT                    DATE            COMMENT 'Invoice document date (when invoice was issued)',
   PURCH_INVOICE_POST_DT               DATE            COMMENT 'Invoice posting date (when invoice was registered in Financial system)',
   SUPPLIER_ORDER_NR                   VARCHAR(20)     COMMENT 'Supplier_2 Order Number present in the Purchase Order',
   SUPPLIER_SID                        NUMBER          COMMENT 'The unique identifier (surrogate key) for supplier_2',
   SUPPLIER_NR                         VARCHAR(20)     COMMENT 'Account_2 number of supplier_2/vendor from the sorce system',
   PROD_VARIANT_SID                    NUMBER          COMMENT 'The unique identifier (surrogate key) for the product variant',
   PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The product variant number',
   INTERNAL_COMPANY_SID                NUMBER          COMMENT 'The unique identifier (surrogate key) for the company',
   INTERNAL_COMPANY_CD                 VARCHAR(5)      COMMENT 'Unique identifier of the company to which we book accounting documents in the source system (SAP)',
   CURR_CD                             VARCHAR(5)      COMMENT 'Currency code in which order has been payed',
   PURCH_AMT_NET_LOCAL_VAL             NUMBER(38, 5)   COMMENT 'The net amount in document currency  represents the value which is allocated to the specific purchase invoice',
   PROD_QTY                            NUMBER(38, 5)   COMMENT 'Quantity of a certain product ordered in a purchasing document',
   TAX_COUNTRY_CD                      VARCHAR(5)      COMMENT 'The unique code for a country_2 according to ISO-3166 Alpha-2. E.g. \"DE\" for Germany or \"FR\" for France',
   TAX_TYPE_CD                         VARCHAR(5)      COMMENT 'The code identifying the tax type',
   REF_DOC_NR                          VARCHAR(20)     COMMENT 'A reference number for linking a material document with a billing document',
   REF_DOC_POS_NR                      VARCHAR(20)     COMMENT 'A reference number for linking a material document position with a billing document position',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_FACT_PURCHASE_INVOICE_LINE PRIMARY KEY (PURCH_INVOICE_NR, PURCH_INVOICE_POS_NR, FISCAL_YEAR) NOT ENFORCED
 )  COMMENT= 'A table that contains one row per purchase invoice line - That is invoices issued by a supplier_2 to a Lidl Purchasing company';
