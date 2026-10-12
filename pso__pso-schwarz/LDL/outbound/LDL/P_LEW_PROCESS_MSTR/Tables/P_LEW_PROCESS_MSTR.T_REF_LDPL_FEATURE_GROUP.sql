/*
#----------------------------------------------------------------------------
# feature group
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-06 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2024-05-21 Marcin Kikoła            AP0206303 Introduction of Loyalty_attribute
#
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_ref_ldpl_feature_group (
loyalty_id BIGNUMERIC(38,0) OPTIONS(description='Loyalty attribute identifier'),
feature_group_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Feature group Id'),
feature_group_desc STRING(250) NOT NULL OPTIONS(description='Feature group description'),
active_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Active flag'),
dwh_load_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (feature_group_id) NOT ENFORCED
) OPTIONS(description='Lidlplus : Feature group');