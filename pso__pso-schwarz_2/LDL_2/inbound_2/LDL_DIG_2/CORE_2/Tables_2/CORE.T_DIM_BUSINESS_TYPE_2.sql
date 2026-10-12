/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_BUSINESS_TYPE_2
   GENERATED FROM POWERDESIGNER ON Montag, 20. November 2023 08:40:54
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_BUSINESS_TYPE_2 (
   BUSINESS_TYPE_CD                    VARCHAR(50)     NOT NULL COMMENT 'The code for business type of the customer ',
   BUSINESS_TYPE_DESCR                 VARCHAR(250)    COMMENT 'The description for business type of the customer ',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_BUSINESS_TYPE PRIMARY KEY (BUSINESS_TYPE_CD) NOT ENFORCED
 )  COMMENT= 'Dimension describes a what type of business is run by a customer ( Education, Law , Gastro)';
