/* --------------------------------------------------------------------------------
   DDL for table: t_survey_version
   generated from Powerdesigner on Montag, 18. November 2024 11:54:16
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_survey_version (
survey_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SURVEY.'),
survey_version_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Version of the survey, allows to track changes in the set of topics in the survey.'),
survey_version_descr STRING(250) OPTIONS(description='Description of the version of the survey.'),
cx_info_provider_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the provider or collector of the customer experience information.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (survey_sid, survey_version_nr) NOT ENFORCED
)
OPTIONS(description='This table contains information about different versions of surveys, i.e. if the set of topics in a survey has been changed.');