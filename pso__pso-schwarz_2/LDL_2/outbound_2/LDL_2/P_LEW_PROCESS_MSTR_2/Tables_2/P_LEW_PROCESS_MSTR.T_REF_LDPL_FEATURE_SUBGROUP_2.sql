/*
#----------------------------------------------------------------------------
# Coupon Type
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-07 Pawel Wieczorek          SD-2524 Initial version
#
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_ref_ldpl_feature_subgroup_2 (
feature_subgroup_id BIGNUMERIC(38,0) NOT NULL,
feature_subgroup_desc STRING(250) NOT NULL,
feature_group_id BIGNUMERIC(38,0) NOT NULL,
active_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
dwh_load_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (feature_subgroup_id) NOT ENFORCED
);