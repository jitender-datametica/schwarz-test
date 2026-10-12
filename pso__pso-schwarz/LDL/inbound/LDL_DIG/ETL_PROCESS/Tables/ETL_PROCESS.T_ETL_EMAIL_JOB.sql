/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_EMAIL_JOB
   GENERATED FROM POWERDESIGNER ON Dienstag, 14. Juni 2022 11:33:00
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_EMAIL_JOB (
   JOB_ID                              NUMBER          NOT NULL COMMENT 'The jobid number of the respective engagement event job ',
   EMAIL_NAME                          VARCHAR(100)    COMMENT 'The name of the email for specific event job (email name associated with jobid) ',
   EMAIL_SUBJECT                       VARCHAR(4000)   COMMENT 'The descriptive subject name of the email',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_EMAIL_JOB PRIMARY KEY (JOB_ID) NOT ENFORCED
 )  COMMENT= 'The ETL lookup table based on the source- emails_job_last5days to get email_name';
