CREATE TABLE ETL_PROCESS.T_ETL_SUBSCRIBER_ACTIVE (
   SUBSCR_SID                          NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the customer',
   SUBSCR_NR                           VARCHAR(50)     COMMENT 'A subscriber number from original system',
   SUB_CHANNEL                         VARCHAR(100),
   SUB_NAME                            VARCHAR(100)    NOT NULL,
   SUB_ORIGIN                          VARCHAR(100),
   SUB_DT                              TIMESTAMP_LTZ   NOT NULL,
   SUB_EMAIL                           VARCHAR(100),
   LEGAL_TXT                           VARCHAR(100),
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   CONSTRAINT PK_T_ETL_SUBSCRIBER_ACTIVE PRIMARY KEY (SUBSCR_SID, SUB_NAME, SUB_DT)
       NOT ENFORCED
)
COMMENT = 'ETL support table for load subscribers';