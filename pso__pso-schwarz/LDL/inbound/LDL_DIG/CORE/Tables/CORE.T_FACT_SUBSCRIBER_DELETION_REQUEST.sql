CREATE TABLE CORE.T_FACT_SUBSCRIBER_DELETION_REQUEST (
   SUBSCR_SID                          NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the customer',
   COUNTRY_CD                          VARCHAR(5)      COMMENT 'The unique code for a country according to ISO-3166 Alpha-2. ( -1 if not filled when request comes for global deletion)',
   DELETION_REQUESTED_TMSP             TIMESTAMP_TZ    NOT NULL COMMENT 'Deletion request date',
   IS_DELETION_COMPLETED_FG            BOOLEAN         COMMENT 'Deletion status flag',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_FACT_SUBSCRIBER_DELETION_ PRIMARY KEY (SUBSCR_SID, DELETION_REQUESTED_TMSP)
       NOT ENFORCED
)COMMENT = 'The request to delete a subscriber. If subscriber has sso_id it should be deleted for all countries. If subscriber does not have an SSO_ID filled the deletion happens only for selected country.';
