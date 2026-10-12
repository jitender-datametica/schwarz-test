CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_customer_survey_score (customer_sid
OPTIONS(description='Unique identifier of the customer (surrogate key).'), survey_sid
OPTIONS(description='Surrogate Key SURVEY.'), survey_version_nr
OPTIONS(description='Version of the survey, allows to track changes in the set of topics in the survey.'),
survey_version_section_name OPTIONS(description='Name of the section in the versioned survey.'), survey_tmsp
OPTIONS(description='Timestamp of the submission of the survey section.'), survey_topic_sid
OPTIONS(description='Surrogate Key SURVEY TOPIC.'), cust_survey_topic_score_fg
OPTIONS(description='Score value of the topic in the store survey if it is a boolean topic type.'),
cust_survey_topic_score_cnt
OPTIONS(description='Score value of the topic in the store survey if it is a count topic type.'),
cust_survey_topic_score_cy
OPTIONS(description='Score value of the topic in the store survey if it is a calendar year topic type.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `THIS TABLE CONTAINS THE ANSWERS FROM CUSTOMERS ON THE TOPICS.`) AS SELECT customer_sid,
 survey_sid,
 survey_version_nr,
 survey_version_section_name,
 survey_tmsp,
 survey_topic_sid,
 cust_survey_topic_score_fg,
 cust_survey_topic_score_cnt,
 cust_survey_topic_score_cy,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_customer_survey_score;