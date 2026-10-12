/*
#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2023-11-07 Pawel Wieczorek    Initial version AP0069622 demographics
#
#------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_ref_gender_1 (gender_cd
OPTIONS(description='The code for the gender'), gender_descr
OPTIONS(description='A textual description for the gender (in default language)'), load_id
OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row create time'), dwh_updated
OPTIONS(description='Row update time')) OPTIONS(DESCRIPTION = `LIDLPLUS : GENDER - REFERENECE TABLE`) AS SELECT
 gender_cd,
 gender_descr,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_ref_gender_1;