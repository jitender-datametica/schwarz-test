CREATE TABLE CORE.T_DIM_ENGAGEMENT_EVENT (
   ENGAGEMENT_EVENT_CD                 VARCHAR(5)      NOT NULL COMMENT 'The unique code for the event type (e.g. s-send, b-bounce)',
   ENGAGEMENT_EVENT_NAME               VARCHAR(100)    NOT NULL COMMENT 'The name of the engagement events (e.g. send, open, click)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_ENGAGEMENT_EVENT PRIMARY KEY (ENGAGEMENT_EVENT_CD) NOT ENFORCED
 )  COMMENT= 'The dimension holds the different engagement event type (e.g. send, open, click)';
