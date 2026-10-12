CREATE TABLE CORE.T_DIM_PRICE_TYPE (
   PRICE_TYPE_CD                       VARCHAR(20)     NOT NULL COMMENT 'Code of type of the price - IVP , regular VKP ( standard price) , promotion/campaign price , etc',
   PRICE_TYPE_DESCR                    VARCHAR(250)    NOT NULL COMMENT 'A textual description for the price type  codes in English',
   PRICE_TYPE_DESCR_DE                 VARCHAR(250)    COMMENT 'A textual description for the price type  codes in group language (German)',
   PRICE_GROUP_CD                      VARCHAR(20)     COMMENT 'Code of pricing group - internal or customer facing',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_PRICE_TYPE PRIMARY KEY (PRICE_TYPE_CD)
       NOT ENFORCED
)COMMENT = 'Detailed Code of type of the price - IVP , regular VKP ( standard price) , promotion/campaign price , etc';
