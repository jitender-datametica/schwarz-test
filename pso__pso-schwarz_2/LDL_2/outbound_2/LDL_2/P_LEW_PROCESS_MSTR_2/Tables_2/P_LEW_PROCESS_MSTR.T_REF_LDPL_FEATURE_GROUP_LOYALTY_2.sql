/*
#----------------------------------------------------------------------------
# feature group loyalty
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2024-05-21 Marcin Kikola          AP0206303 Introduction of Loyalty_attribute
#
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_ref_ldpl_feature_group_loyalty_2 (
loyalty_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Loyalty attribute identifier'),
loyalty_desc STRING(250) OPTIONS(description='Loyalty attribute description'),
dwh_load_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (loyalty_id) NOT ENFORCED
) OPTIONS(description='Lidl Plus Loyalty');