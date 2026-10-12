/* --------------------------------------------------------------------------------
   DDL for table: t_survey_version_section
   generated from Powerdesigner on Montag, 18. November 2024 11:54:24
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_survey_version_section (
survey_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SURVEY.'),
survey_version_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Version of the survey, allows to track changes in the set of topics in the survey.'),
survey_version_section_name STRING(100) NOT NULL OPTIONS(description='Name of the section in the versioned survey. '),
cx_info_provider_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the provider or collector of the customer experience information.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (survey_sid, survey_version_nr, survey_version_section_name) NOT ENFORCED
)
OPTIONS(description='A section of a versioned survey is a part of the survey which consists of a set of topics for which the answers are submitted and stored together.');