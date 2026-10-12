CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_survey_topic_group_1 (survey_topic_grp_sid
OPTIONS(description='Surrogate Key SURVEY TOPIC GROUP.'), survey_topic_grp_name
OPTIONS(description='Name of the survey topic group.'), survey_topic_grp_type_cd
OPTIONS(description='Type Code of the survey topic group'), survey_topic_grp_descr
OPTIONS(description='Description of the survey topic group.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `THIS TABLE CONTAINS INFORMATION ABOUT GROUPS OF  TOPICS.`) AS SELECT survey_topic_grp_sid,
 survey_topic_grp_name,
 survey_topic_grp_type_cd,
 survey_topic_grp_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_survey_topic_group_1;