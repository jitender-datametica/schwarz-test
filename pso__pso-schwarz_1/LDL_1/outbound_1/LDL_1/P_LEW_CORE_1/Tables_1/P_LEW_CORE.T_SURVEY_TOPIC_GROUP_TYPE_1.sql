/* --------------------------------------------------------------------------------
   DDL for table: t_survey_topic_group_type_1
   generated from Powerdesigner on Montag, 18. November 2024 11:55:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_survey_topic_group_type_1 (
survey_topic_grp_type_cd STRING(100) NOT NULL OPTIONS(description='Type code of the survey topic group.'),
survey_topic_grp_type_descr STRING(250) OPTIONS(description='Description of the survey topic group.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (survey_topic_grp_type_cd) NOT ENFORCED
)
OPTIONS(description='This table contains the type of a survey topic group based on the implementation of the topic in the UI with respect to the answer option type (single choice / multiple choice) and the complexity of the answer structure implementation (usage of chip components).');