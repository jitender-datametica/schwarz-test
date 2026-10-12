/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_SUPPLIER
   GENERATED FROM POWERDESIGNER ON Dienstag, 8. August 2023 14:51:08
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_SUPPLIER (
   SUPPLIER_SID                        NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for supplier',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   SUPPLIER_NR                         VARCHAR(20)     COMMENT 'Account number of supplier/vendor from the sorce system',
   SUPPLIER_NAME                       VARCHAR(100)    COMMENT 'Company name of the supplier/vendor.',
   SUPPLIER_FULL_NAME                  VARCHAR(100)    COMMENT 'Full company name of the supplier/vendor.',
   ADDR_SID                            NUMBER          COMMENT 'Address associated with the supplier account.',
   ORIG_COUNTRY_CD                     VARCHAR(5)      COMMENT 'Country where the supplier account is based.',
   ZIP_CD                              VARCHAR(100)    COMMENT 'A zip code of the address associated with the supplier',
   CITY_NAME                           VARCHAR(100)    COMMENT 'City name of the address associated with the supplier',
   STREET_NAME                         VARCHAR(100)    COMMENT 'The name of a street in the address associated with the supplier',
   SUPPLIER_SRC_INSERT_DT              DATE            COMMENT 'Date when the supplier was added to the ERP system.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',
   CONSTRAINT PK_T_DIM_SUPPLIER PRIMARY KEY (SUPPLIER_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'Supplier ( lieferant )';
