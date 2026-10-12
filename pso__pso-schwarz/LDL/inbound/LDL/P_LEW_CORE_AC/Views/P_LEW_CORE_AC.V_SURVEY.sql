CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_SURVEY (
   survey_sid                               COMMENT 'Surrogate Key SURVEY.'
  ,cx_info_provider_nr                      COMMENT 'Identifier of the provider or collector of the customer experience information.'
  ,survey_name                              COMMENT 'Name of the survey.'
  ,survey_descr                             COMMENT 'Description of the survey.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'This table contains general information about ditfferent surveys.'
AS SELECT
   survey_sid
  ,cx_info_provider_nr
  ,survey_name
  ,survey_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_SURVEY
;