CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_SURVEY_TOPIC_GROUP_TYPE (
   survey_topic_grp_type_cd                 COMMENT 'Type code of the survey topic group.'
  ,survey_topic_grp_type_descr              COMMENT 'Description of the survey topic group.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'This table contains the type of a survey topic group based on the implementation of the topic in the UI with respect to the answer option type (single choice / multiple choice) and the complexity of the answer structure implementation (usage of chip components).'
AS SELECT
   survey_topic_grp_type_cd
  ,survey_topic_grp_type_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_SURVEY_TOPIC_GROUP_TYPE
;