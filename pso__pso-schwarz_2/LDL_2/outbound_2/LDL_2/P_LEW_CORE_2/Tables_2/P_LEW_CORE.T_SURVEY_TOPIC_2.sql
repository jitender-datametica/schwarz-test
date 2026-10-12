/* --------------------------------------------------------------------------------
   DDL for table: t_survey_topic_2
   generated from Powerdesigner on Montag, 18. November 2024 11:55:18
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_survey_topic_2 (
survey_topic_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SURVEY TOPIC.'),
survey_topic_name STRING(100) OPTIONS(description='Name of the survey topic.'),
survey_topic_type_cd STRING(100) OPTIONS(description='Code of the survey topic type'),
survey_topic_descr STRING(250) OPTIONS(description='Description of the survey topic.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (survey_topic_sid) NOT ENFORCED
) OPTIONS(description='This table contains information about the topics used in surveys.');