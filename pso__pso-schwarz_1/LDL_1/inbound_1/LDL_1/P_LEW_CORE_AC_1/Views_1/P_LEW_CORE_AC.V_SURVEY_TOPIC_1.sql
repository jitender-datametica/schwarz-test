CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_SURVEY_TOPIC_1 (
   survey_topic_sid                         COMMENT 'Surrogate Key SURVEY TOPIC.'
  ,survey_topic_name                        COMMENT 'Name of the survey topic.'
  ,survey_topic_type_cd                     COMMENT 'Code of the survey topic type'
  ,survey_topic_descr                       COMMENT 'Description of the survey topic.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'This table contains information about the topics used in surveys.'
AS SELECT
   survey_topic_sid
  ,survey_topic_name
  ,survey_topic_type_cd
  ,survey_topic_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_SURVEY_TOPIC_1
;