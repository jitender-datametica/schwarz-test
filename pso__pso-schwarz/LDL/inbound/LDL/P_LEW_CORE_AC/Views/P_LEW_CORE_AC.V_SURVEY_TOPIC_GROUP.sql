CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_SURVEY_TOPIC_GROUP (
   survey_topic_grp_sid                     COMMENT 'Surrogate Key SURVEY TOPIC GROUP.'
  ,survey_topic_grp_name                    COMMENT 'Name of the survey topic group.'
  ,survey_topic_grp_type_cd                 COMMENT 'Type Code of the survey topic group'
  ,survey_topic_grp_descr                   COMMENT 'Description of the survey topic group.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'This table contains information about groups of  topics.'
AS SELECT
   survey_topic_grp_sid
  ,survey_topic_grp_name
  ,survey_topic_grp_type_cd
  ,survey_topic_grp_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_SURVEY_TOPIC_GROUP
;