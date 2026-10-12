CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_SURVEY_TOPIC_TYPE_2 (
   survey_topic_type_cd                     COMMENT 'Code of the survey topic type.'
  ,survey_topic_type_descr                  COMMENT 'Description of the survey topic type.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'This table contains the different types of survey topics based on the data domain of the answer.'
AS SELECT
   survey_topic_type_cd
  ,survey_topic_type_descr
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_SURVEY_TOPIC_TYPE_2
;