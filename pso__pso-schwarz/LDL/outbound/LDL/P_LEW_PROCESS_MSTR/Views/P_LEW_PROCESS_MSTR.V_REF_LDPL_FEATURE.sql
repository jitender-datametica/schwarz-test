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


CREATE OR REPLACE VIEW ldl_p_lew_process_mstr.v_ref_ldpl_feature (feature_id OPTIONS(description='Feature identifier'),
feature_desc OPTIONS(description='Feature description'), feature_subgroup_id
OPTIONS(description='Feature subgroup description'), dwh_load_id OPTIONS(description='Load identifier'), dwh_created
OPTIONS(description='Row insert time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `LIDL PLUS FEATURE`) AS SELECT feature_id,
 feature_desc,
 feature_subgroup_id,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_ref_ldpl_feature;