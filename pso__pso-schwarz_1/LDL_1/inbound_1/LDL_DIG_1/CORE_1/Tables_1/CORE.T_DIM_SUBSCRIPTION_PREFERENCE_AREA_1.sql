CREATE TABLE CORE.T_DIM_SUBSCRIPTION_PREFERENCE_AREA_1 (
   SUBSCR_PREF_AREA_CD                 VARCHAR(20)     NOT NULL COMMENT 'The code for the area subscriber is interested in',
   SUBSCR_PREF_AREA_DESC               VARCHAR(250)    NOT NULL COMMENT 'The description for the area subscriber is interested in',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_SUBSCRIPTION_PREFEREN PRIMARY KEY (SUBSCR_PREF_AREA_CD)
       NOT ENFORCED
)COMMENT = 'This minor dimension defines the subscription area that the subscriber is interested in ( known to business as subname )';
