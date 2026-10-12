CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_CUSTOMER_SURVEY_SECTION_2 (
   customer_sid                             COMMENT 'Unique identifier of the customer (surrogate key).'
  ,survey_sid                               COMMENT 'Surrogate Key SURVEY.'
  ,survey_version_nr                        COMMENT 'Version of the survey, allows to track changes in the set of topics in the survey.'
  ,survey_version_section_name              COMMENT 'Name of the section in the versioned survey.'
  ,survey_tmsp                              COMMENT 'Timestamp of the submission of the survey section.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'This table contains the survey sections for which customers have provided their answers at a certain point in time.'
AS SELECT
   customer_sid
  ,survey_sid
  ,survey_version_nr
  ,survey_version_section_name
  ,survey_tmsp
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_CUSTOMER_SURVEY_SECTION_2
;