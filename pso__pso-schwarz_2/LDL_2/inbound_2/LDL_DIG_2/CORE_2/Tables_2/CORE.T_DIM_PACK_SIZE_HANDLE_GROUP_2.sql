CREATE TABLE CORE.T_DIM_PACK_SIZE_HANDLE_GROUP_2 (
   PACK_SIZE_HANDLE_GROUP_CD           VARCHAR(5)      NOT NULL COMMENT 'A code for packaging size classification grouped in the bigger buckets based on how many effort is required to handle it - '' 1 person''  , ''2 persons'' etc',
   PACK_SIZE_HANDLE_GROUP_DESCR        VARCHAR(250)    NOT NULL COMMENT 'A textual description for the packaging size classification in group language (German).',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_DIM_PACK_SIZE_HANDLE_GROUP PRIMARY KEY (PACK_SIZE_HANDLE_GROUP_CD) NOT ENFORCED 
)  COMMENT = 'This minor dimension for packaging size classification grouped in the bigger buckets based on how many effort is required to handle it - '' 1 person''  , ''2 persons'' etc';

