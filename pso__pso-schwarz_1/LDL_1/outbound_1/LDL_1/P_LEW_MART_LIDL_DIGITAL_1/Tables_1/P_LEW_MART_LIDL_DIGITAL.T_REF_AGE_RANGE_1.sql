/*
#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2023-11-07 Pawel Wieczorek    Initial version AP0069622 demographics
#  1.1 2024-01-11 Pawel Wieczorek    AP0069622 demographics changed precission of age_range_descr to 250
#------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_ref_age_range_1 (
age_range_cd STRING(10) NOT NULL OPTIONS(description='The code for the age range.'),
age_range_descr STRING(250) NOT NULL OPTIONS(description='The code for the age range.'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (age_range_cd) NOT ENFORCED
) OPTIONS(description='Lidlplus : demographical data ref age range');