CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_survey_version_topic_2 (survey_sid OPTIONS(description='Surrogate Key SURVEY.'),
survey_version_nr
OPTIONS(description='Version of the survey, allows to track changes in the set of topics in the survey.'),
survey_version_section_name OPTIONS(description='Name of the section in the versioned survey. '), survey_topic_sid
OPTIONS(description='Surrogate Key SURVEY TOPIC.'), survey_topic_grp_sid
OPTIONS(description='Surrogate Key SURVEY TOPIC GROUP.'), cx_info_provider_nr
OPTIONS(description='Identifier of the provider or collector of the customer experience information.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `THIS TABLE CONTAINS INFORMATION ABOUT WHICH TOPICS ARE USED IN WHICH SURVEY VERSIONS.`) AS SELECT
 survey_sid,
 survey_version_nr,
 survey_version_section_name,
 survey_topic_sid,
 survey_topic_grp_sid,
 cx_info_provider_nr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_survey_version_topic_2;