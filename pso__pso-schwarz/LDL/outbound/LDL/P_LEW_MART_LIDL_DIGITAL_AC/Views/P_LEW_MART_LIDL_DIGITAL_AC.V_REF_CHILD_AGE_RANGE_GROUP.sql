/*
#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2024-06-28 Pawel Wieczorek    Initial version feature/AP0225100_Attributes_About_Me
#  1.1 2024-09-12 Pawel Wieczorek    feature/AP0225100_Attributes_About_Me Added column
#------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_ref_child_age_range_group (child_age_range_group_id
OPTIONS(description='Group age range identifier'), child_age_range_cd
OPTIONS(description='Code of the age range in which the child is categorized depending on the age.'),
child_age_range_name OPTIONS(description='Name of the child age range.'), child_age_range_descr
OPTIONS(description='Description of the child age range.'), child_age_range_short_descr
OPTIONS(description='Short description of the child age range.'), load_id OPTIONS(description='Load identifier'),
dwh_created OPTIONS(description='Row create time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `LIDLPLUS : GROUPED AGE RANGES OF CHILDREN`) AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_ref_child_age_range_group AS T;