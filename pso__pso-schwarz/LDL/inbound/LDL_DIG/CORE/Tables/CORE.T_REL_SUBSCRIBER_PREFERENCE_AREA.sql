CREATE TABLE CORE.T_REL_SUBSCRIBER_PREFERENCE_AREA (
   COUNTRY_CD                          VARCHAR(5)      NOT NULL COMMENT 'The unique code for a country according to ISO-3166 Alpha-2. E.g. \"DE\" for Germany or \"FR\" for France',
   SUBSCR_SID                          NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the customer',
   SUBSCR_PREF_AREA_CD                 VARCHAR(20)     NOT NULL COMMENT 'The code for the area subscriber is interested in',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   SUBSCR_STATUS_CD                    VARCHAR(5)      COMMENT 'The code for the status of  subscription to particular area ( requested, unsubscribed, subscribed)',
   SUBSCR_CHANNEL_NAME                 VARCHAR(100)    COMMENT 'The name that defines the channel of customer subscription',
   SUBSCR_ORIGIN_FORM_NAME             VARCHAR(100)    COMMENT 'The name of the form for origin of customer subscription',
   LEGAL_TXT_VERSION_NAME              VARCHAR(100)    COMMENT 'Legal Text version name',
   SUBSCR_TMSP                         TIMESTAMP_TZ    COMMENT 'The timestamp when the actual subscription took place',
   SUBSCR_PROCESSED_TMSP               TIMESTAMP_TZ    COMMENT 'The timestamp when the request for subscribing took place',
   UNSUBSCR_TMSP                       TIMESTAMP_TZ    COMMENT 'The timestamp when the actual unsubscription took place',
   UNSUBSCR_PROCESSED_TMSP             TIMESTAMP_TZ    COMMENT 'The timestamp when the request for unsubscribing took place',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source tables',
   CONSTRAINT PK_T_REL_SUBSCRIBER_PREFERENCE PRIMARY KEY (COUNTRY_CD, SUBSCR_SID, SUBSCR_PREF_AREA_CD, DWH_VALID_FROM_TMSP)
       NOT ENFORCED
)COMMENT = 'Subscriber can subscribe to different areas of interest';