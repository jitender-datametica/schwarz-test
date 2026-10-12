/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_SUPPLIER_ORDER_HEADER
   GENERATED FROM POWERDESIGNER ON Dienstag, 15. Dezember 2022 11:34:05
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_SUPPLIER_ORDER_HEADER (
   SUPPLIER_ORDER_NR                   VARCHAR(20)     NOT NULL COMMENT 'Supplier Order Number present in the Purchase Order',
   SUPPLIER_ORDER_TYPE_CD              VARCHAR(5)      COMMENT 'The unique code for the purchase order document  ',
   SUPPLIER_ORDER_DT                   DATE            COMMENT 'The order date of the purchase document. It can be different from the creation date in SAP.',
   SUPPLIER_SID                        NUMBER          COMMENT 'The unique identifier (surrogate key) for supplier account number present in the purchaseorder',
   SUPPLIER_NR                         VARCHAR(20)     COMMENT 'Account number of supplier/vendor from the sorce system',
   CURR_CD                             VARCHAR(5)      COMMENT 'Currency code',
   TAX_COUNTRY_CD                      VARCHAR(5)      COMMENT 'The unique code for a country according to ISO-3166 Alpha-2. E.g. \"DE\" for Germany or \"FR\" for France',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_SUPPLIER_ORDER_HEADER PRIMARY KEY (SUPPLIER_ORDER_NR) NOT ENFORCED
 )  COMMENT= 'The ETL support table for supplier order header detail';
