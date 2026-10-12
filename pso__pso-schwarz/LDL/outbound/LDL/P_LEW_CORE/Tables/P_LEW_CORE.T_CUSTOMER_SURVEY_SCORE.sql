/* --------------------------------------------------------------------------------
   DDL for table: t_customer_survey_score
   generated from Powerdesigner on Montag, 18. November 2024 11:55:43
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_customer_survey_score (
customer_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unique identifier of the customer (surrogate key).'),
survey_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SURVEY.'),
survey_version_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Version of the survey, allows to track changes in the set of topics in the survey.'),
survey_version_section_name STRING(100) NOT NULL OPTIONS(description='Name of the section in the versioned survey.'),
survey_tmsp DATETIME NOT NULL OPTIONS(description='Timestamp of the submission of the survey section.'),
survey_topic_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SURVEY TOPIC.'),
cust_survey_topic_score_fg BIGNUMERIC(38,0)
OPTIONS(description='Score value of the topic in the store survey if it is a boolean topic type.'),
cust_survey_topic_score_cnt BIGNUMERIC(38,0)
OPTIONS(description='Score value of the topic in the store survey if it is a count topic type.'),
cust_survey_topic_score_cy BIGNUMERIC(38,0)
OPTIONS(description='Score value of the topic in the store survey if it is a calendar year topic type.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (survey_topic_sid, customer_sid, survey_sid, survey_version_nr, survey_version_section_name, survey_tmsp)
NOT ENFORCED
) OPTIONS(description='This table contains the answers from customers on the topics.');