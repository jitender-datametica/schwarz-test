CREATE TABLE CORE.T_DIM_WEB_APP_2 (
   WEB_APP_TYPE_NAME                   VARCHAR(100)    NOT NULL COMMENT 'Name of the web app/client type (iOS App / Android App / Mobile Web / Desktop Web ...) ',
   GA_SRC_NAME                         VARCHAR(100)    NOT NULL COMMENT 'The code for the the source of google analytics (WEB or APP)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_WEB_APP PRIMARY KEY (WEB_APP_TYPE_NAME, GA_SRC_NAME)
       NOT ENFORCED
)
COMMENT = 'A dimensions that contains possible web applications / client types. (iOS App / Android App / Mobile Web / Desktop Web ...)';
