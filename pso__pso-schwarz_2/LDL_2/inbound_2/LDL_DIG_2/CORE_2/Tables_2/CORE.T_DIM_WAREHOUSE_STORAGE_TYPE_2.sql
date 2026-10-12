/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_WAREHOUSE_STORAGE_TYPE_2
   GENERATED FROM POWERDESIGNER ON Montag, 26. September 2022 16:29:59
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_WAREHOUSE_STORAGE_TYPE_2 (
   WH_STORAGE_TYPE_CD                  VARCHAR(5)      NOT NULL COMMENT 'The code for the type of warehouse storage ((KK,GT ...)',
   WH_STORAGE_TYPE_DESCR               VARCHAR(250)    NOT NULL COMMENT 'A textual description for the type for the warehouse storage (KK = small items warehouse,GT = large items warehouse)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_WAREHOUSE_STORAGE_TYPE PRIMARY KEY (WH_STORAGE_TYPE_CD) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the storage type for the warehouse (KK = small items warehouse,GT = large items warehouse,Wein = wine & spririts)';
