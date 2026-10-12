/*
#----------------------------------------------------------------------------
# Coupon Type
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-12-15 Pawel Wieczorek          SD-2524 Initial version
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_process_mstr.v_ref_ldpl_feature_group_2 (loyalty_id
OPTIONS(description='Loyalty atrtibute identifier'), feature_group_id OPTIONS(description='Feature_group identifier'),
feature_group_desc OPTIONS(description='Feature_group description'), active_fg OPTIONS(description='Activity Flag'),
dwh_load_id OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row insert time'), dwh_updated
OPTIONS(description='Row update time')) OPTIONS(DESCRIPTION = `LIDL PLUS FEATURE GROUP`) AS SELECT loyalty_id,
 feature_group_id,
 feature_group_desc,
 active_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_ref_ldpl_feature_group_2;