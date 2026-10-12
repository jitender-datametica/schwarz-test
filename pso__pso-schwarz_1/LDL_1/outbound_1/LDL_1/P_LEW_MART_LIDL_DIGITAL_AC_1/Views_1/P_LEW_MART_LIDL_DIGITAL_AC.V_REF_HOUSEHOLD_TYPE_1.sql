/*
#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2024-06-28 Pawel Wieczorek    Initial version feature/AP0225100_Attributes_About_Me
#------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_ref_household_type_1 (household_type_id
OPTIONS(description='ID of the household type in which the customer lives.'), household_type_descr
OPTIONS(description='Description of the household type in which the customer lives.'), load_id
OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row create time'), dwh_updated
OPTIONS(description='Row update time')) OPTIONS(DESCRIPTION = `LIDLPLUS : TYPE OF THE HOUSEHOLD`) AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_ref_household_type_1 AS T;