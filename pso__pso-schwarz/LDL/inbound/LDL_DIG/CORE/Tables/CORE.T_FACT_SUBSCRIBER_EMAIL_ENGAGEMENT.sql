/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_SUBSCRIBER_EMAIL_ENGAGEMENT
   GENERATED FROM POWERDESIGNER ON Mittwoch, 15. Juni 2022 16:53:17
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_SUBSCRIBER_EMAIL_ENGAGEMENT (
   SUBSCR_SID                          NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the subscriber',
   JOB_ID                              NUMBER          NOT NULL COMMENT 'The jobid number of the respective engagement event job ',
   EMAIL_NAME                          VARCHAR(100)    COMMENT 'The name of the email for specific event job (email name associated with jobid) ',
   ENGAGEMENT_EVENT_TMSP               TIMESTAMP_LTZ   NOT NULL COMMENT 'The timestamp when the engagement event happened',
   ENGAGEMENT_EVENT_CD                 VARCHAR(5)      COMMENT 'The unique code to identify the engagement event',
   EMAIL_LINK_NAME                     VARCHAR(1024)   COMMENT 'The name of the link present in the email ',
   EMAIL_LINK_CONTENT_TXT              VARCHAR(16777216) COMMENT 'The text content of the link present in the email',
   BOUNCE_CATEGORY_ID                  NUMBER          COMMENT 'The numeric identifier to uniquely identify the bounce categories',
   COUNTRY_CD                          VARCHAR(5)      COMMENT 'The unique code for a country according to ISO-3166 Alpha-2. E.g. \"DE\" for Germany or \"FR\" for France',
   COUPON_CD                           VARCHAR(50)     COMMENT 'The business key that uniquely identifies a coupon',
   BATCH_ID                            NUMBER          COMMENT 'The identical number for batch associated with the group of jobs',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_FACT_SUBSCRIBER_EMAIL_ENGAGEMENT PRIMARY KEY (SUBSCR_SID, JOB_ID, ENGAGEMENT_EVENT_TMSP) NOT ENFORCED
 )  COMMENT= 'The fact holds the email engagement events of subscribers';
