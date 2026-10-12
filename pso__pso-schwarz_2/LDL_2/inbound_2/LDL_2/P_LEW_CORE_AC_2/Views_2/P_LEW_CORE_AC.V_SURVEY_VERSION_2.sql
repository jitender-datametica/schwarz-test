CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_SURVEY_VERSION_2 (
   survey_sid                               COMMENT 'Surrogate Key SURVEY.'
  ,survey_version_nr                        COMMENT 'Version of the survey, allows to track changes in the set of topics in the survey.'
  ,survey_version_descr                     COMMENT 'Description of the version of the survey.'
  ,cx_info_provider_nr                      COMMENT 'Identifier of the provider or collector of the customer experience information.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'This table contains information about different versions of surveys, i.e. if the set of topics in a survey has been changed.'
AS SELECT
   survey_sid
  ,survey_version_nr
  ,survey_version_descr
  ,cx_info_provider_nr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_SURVEY_VERSION_2
;