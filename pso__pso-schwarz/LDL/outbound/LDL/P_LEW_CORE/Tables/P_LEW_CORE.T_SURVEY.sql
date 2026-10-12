/* --------------------------------------------------------------------------------
   DDL for table: t_survey
   generated from Powerdesigner on Montag, 18. November 2024 11:54:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_survey (
survey_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SURVEY.'),
cx_info_provider_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the provider or collector of the customer experience information.'),
survey_name STRING(100) NOT NULL OPTIONS(description='Name of the survey.'),
survey_descr STRING(250) OPTIONS(description='Description of the survey.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (survey_sid) NOT ENFORCED
) OPTIONS(description='This table contains general information about ditfferent surveys.');