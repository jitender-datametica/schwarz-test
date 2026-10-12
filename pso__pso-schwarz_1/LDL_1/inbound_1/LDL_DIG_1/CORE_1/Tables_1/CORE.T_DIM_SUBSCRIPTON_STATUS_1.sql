CREATE TABLE CORE.T_DIM_SUBSCRIPTON_STATUS_1 (
   SUBSCR_STATUS_CD                    VARCHAR(5)      NOT NULL COMMENT 'The code for the status_1 of  subscription to particular area ( requested, unsubscribed, subscribed)',
   SUBSCR_STATUS_DESCR                 VARCHAR(250)    NOT NULL COMMENT 'A textual description for the status_1 of subscription',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_SUBSCRIPTON_STATUS PRIMARY KEY (SUBSCR_STATUS_CD)
       NOT ENFORCED
)COMMENT = 'This minor dimension defines the status_1 of  subscription to particular area ( requested, unsubscribed, subscribed)';
