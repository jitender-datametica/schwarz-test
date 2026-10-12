CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_survey_topic (survey_topic_sid
OPTIONS(description='Surrogate Key SURVEY TOPIC.'), survey_topic_name OPTIONS(description='Name of the survey topic.'),
survey_topic_type_cd OPTIONS(description='Code of the survey topic type'), survey_topic_descr
OPTIONS(description='Description of the survey topic.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `THIS TABLE CONTAINS INFORMATION ABOUT THE TOPICS USED IN SURVEYS.`) AS SELECT survey_topic_sid,
 survey_topic_name,
 survey_topic_type_cd,
 survey_topic_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_survey_topic;