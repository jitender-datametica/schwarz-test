CREATE TABLE CORE.T_DIM_BOUNCE_CATEGORY_1 (
   BOUNCE_CATEGORY_ID                  NUMBER          NOT NULL COMMENT 'The numeric identifier to uniquely identify the bounce categories',
   BOUNCE_CATEGORY_NAME                VARCHAR(100)    NOT NULL COMMENT 'The name of the bounce category type (e.g. soft, block)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_BOUNCE_CATEGORY PRIMARY KEY (BOUNCE_CATEGORY_ID) NOT ENFORCED
 )  COMMENT= 'This dimension holds the different bounce categories based on the reason the email bounced (e.g. soft bounce)';
