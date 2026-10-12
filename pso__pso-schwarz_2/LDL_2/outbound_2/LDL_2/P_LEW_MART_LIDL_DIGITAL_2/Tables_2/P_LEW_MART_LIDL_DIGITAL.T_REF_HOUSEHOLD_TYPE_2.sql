/*
#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2024-06-28 Pawel Wieczorek    Initial version feature/AP0225100_Attributes_About_Me
#------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_ref_household_type_2 (
household_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID of the household type in which the customer lives.'),
household_type_descr STRING(250) NOT NULL
OPTIONS(description='Description of the household type in which the customer lives.'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (household_type_id) NOT ENFORCED
) OPTIONS(description='Lidlplus : type of the household');