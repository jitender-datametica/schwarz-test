/*

#===============================================================================
# History
#  1.0 2024-07-02 Pawel Wieczorek    Initial version feature/AP0225100_Attributes_About_Me


#===============================================================================
#
*/

/* ==============================================================================
   View DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_cust_demogr_1 (client_id OPTIONS(description='Client identifier'),
customer_sid OPTIONS(description='Surrogate Key CUSTOMER'), gender_cd OPTIONS(description='The code for the gender'),
age_range_cd OPTIONS(description='The code for the age range.'), load_id OPTIONS(description='Load identifier'),
dwh_created OPTIONS(description='Row create time'), dwh_updated OPTIONS(description='Row update time'),
household_type_id OPTIONS(description='ID of the household type in which the customer lives.'), child_age_range_group_id
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'),
child_age_range_group_fg OPTIONS(description='Age range group indicator, Y when child_age_range_group_id > 0 else N'))
OPTIONS(DESCRIPTION = `LIDLPLUS : DEMOGRAPHICAL DATA`) AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_cust_demogr_1 AS T;