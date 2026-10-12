CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_CUSTOMER_SURVEY_SCORE (
   customer_sid                             COMMENT 'Unique identifier of the customer (surrogate key).'
  ,survey_sid                               COMMENT 'Surrogate Key SURVEY.'
  ,survey_version_nr                        COMMENT 'Version of the survey, allows to track changes in the set of topics in the survey.'
  ,survey_version_section_name              COMMENT 'Name of the section in the versioned survey.'
  ,survey_tmsp                              COMMENT 'Timestamp of the submission of the survey section.'
  ,survey_topic_sid                         COMMENT 'Surrogate Key SURVEY TOPIC.'
  ,cust_survey_topic_score_fg               COMMENT 'Score value of the topic in the store survey if it is a boolean topic type.'
  ,cust_survey_topic_score_cnt              COMMENT 'Score value of the topic in the store survey if it is a count topic type.'
  ,cust_survey_topic_score_cy               COMMENT 'Score value of the topic in the store survey if it is a calendar year topic type.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH.'
)
COMMENT = 'This table contains the answers from customers on the topics.'
AS SELECT
   customer_sid
  ,survey_sid
  ,survey_version_nr
  ,survey_version_section_name
  ,survey_tmsp
  ,survey_topic_sid
  ,cust_survey_topic_score_fg
  ,cust_survey_topic_score_cnt
  ,cust_survey_topic_score_cy
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_CUSTOMER_SURVEY_SCORE
;