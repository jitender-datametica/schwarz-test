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


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_ref_child_age_range_group_2 (
child_age_range_group_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Group age range identifier'),
child_age_range_cd STRING(100) NOT NULL
OPTIONS(description='Code of the age range in which the child is categorized depending on the age.'),
child_age_range_name STRING(100) NOT NULL OPTIONS(description='Name of the child age range.'),
child_age_range_descr STRING(250) NOT NULL OPTIONS(description='Description of the child age range.'),
child_age_range_short_descr STRING(100) OPTIONS(description='Short description of the child age range.'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (child_age_range_group_id, child_age_range_cd) NOT ENFORCED
) OPTIONS(description='Lidlplus : grouped age ranges of children');