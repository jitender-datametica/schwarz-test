CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_survey (survey_sid OPTIONS(description='Surrogate Key SURVEY.'),
cx_info_provider_nr
OPTIONS(description='Identifier of the provider or collector of the customer experience information.'), survey_name
OPTIONS(description='Name of the survey.'), survey_descr OPTIONS(description='Description of the survey.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `THIS TABLE CONTAINS GENERAL INFORMATION ABOUT DITFFERENT SURVEYS.`) AS SELECT survey_sid,
 cx_info_provider_nr,
 survey_name,
 survey_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_survey;