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


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_ref_gender_2 (
gender_cd STRING(5) NOT NULL OPTIONS(description='The code for the gender'),
gender_descr STRING(250) NOT NULL OPTIONS(description='A textual description for the gender (in default language)'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (gender_cd) NOT ENFORCED
) OPTIONS(description='Lidlplus : gender - referenece table');