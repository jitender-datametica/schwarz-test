CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_survey_topic_group_type (survey_topic_grp_type_cd
OPTIONS(description='Type code of the survey topic group.'), survey_topic_grp_type_descr
OPTIONS(description='Description of the survey topic group.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `THIS TABLE CONTAINS THE TYPE OF A SURVEY TOPIC GROUP BASED ON THE IMPLEMENTATION OF THE TOPIC IN THE UI WITH RESPECT TO THE ANSWER OPTION TYPE (SINGLE CHOICE / MULTIPLE CHOICE) AND THE COMPLEXITY OF THE ANSWER STRUCTURE IMPLEMENTATION (USAGE OF CHIP COMPONENTS).`)
AS SELECT survey_topic_grp_type_cd,
 survey_topic_grp_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_survey_topic_group_type;