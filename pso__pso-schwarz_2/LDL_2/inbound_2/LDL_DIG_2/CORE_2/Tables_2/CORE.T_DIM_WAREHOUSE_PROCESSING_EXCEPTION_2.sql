/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_WAREHOUSE_PROCESSING_EXCEPTION_2
   GENERATED FROM POWERDESIGNER ON Montag, 15. Juli 2024 15:34:14
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_WAREHOUSE_PROCESSING_EXCEPTION_2 (
   WH_PROCESSING_EXCEPTION_CD          VARCHAR(5)      NOT NULL COMMENT 'This code describes exceptions which took place during processing of the warehouse task because of unexpected issues. (e.g. ZHBD)',
   WH_PROCESSING_EXCEPTION_DESCR       VARCHAR(250)    NOT NULL COMMENT 'The description for warehouse processing exception (e.g. Change Destination Bin and storage type)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_DIM_WAREHOUSE_PROCESSING_EXCEPTION PRIMARY KEY (WH_PROCESSING_EXCEPTION_CD) NOT ENFORCED 
)  COMMENT = 'The minor dimension defines exceptions which can take place during processing of a warehouse task because of unexpected issues. (e.g. ZHBD = Change Destination Bin and storage type - this code can be chosen whenever the destination for a putaway task had to be changed because the initially chosen shelf was broken/dirty, etc.)';
