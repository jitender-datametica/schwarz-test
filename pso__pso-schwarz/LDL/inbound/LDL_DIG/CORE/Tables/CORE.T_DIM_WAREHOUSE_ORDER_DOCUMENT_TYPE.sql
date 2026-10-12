/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_WAREHOUSE_ORDER_DOCUMENT_TYPE
   GENERATED FROM POWERDESIGNER ON Dienstag, 14. Juni 2022 09:48:06
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_WAREHOUSE_ORDER_DOCUMENT_TYPE (
   WH_ORDER_DOC_TYPE_CD                VARCHAR(5)      NOT NULL COMMENT 'The code for warehouse order type',
   WH_ORDER_TYPE_DOC_DESCR             VARCHAR(250)    NOT NULL COMMENT 'The description for warehouse order type',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_WAREHOUSE_ORDER_DOCUMENT_TYPE PRIMARY KEY (WH_ORDER_DOC_TYPE_CD) NOT ENFORCED
 )  COMMENT= 'The minor dimension that holds the warehouse order type ';
