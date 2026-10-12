/* --------------------------------------------------------------------------------
   DDL for table: t_survey_topic_type
   generated from Powerdesigner on Montag, 18. November 2024 11:55:27
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_survey_topic_type (
survey_topic_type_cd STRING(100) NOT NULL OPTIONS(description='Code of the survey topic type.'),
survey_topic_type_descr STRING(250) OPTIONS(description='Description of the survey topic type.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (survey_topic_type_cd) NOT ENFORCED
)
OPTIONS(description='This table contains the different types of survey topics based on the data domain of the answer.');