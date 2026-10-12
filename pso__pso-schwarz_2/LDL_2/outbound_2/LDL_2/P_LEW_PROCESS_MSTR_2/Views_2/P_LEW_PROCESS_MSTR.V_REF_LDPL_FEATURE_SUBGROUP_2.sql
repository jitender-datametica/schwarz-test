/*
#----------------------------------------------------------------------------
# Coupon Type
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-12-15 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2022-02-10 Marcin Kikola            Additional column feature_group_id is added
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_process_mstr.v_ref_ldpl_feature_subgroup_2 (feature_subgroup_id
OPTIONS(description='Feature subgroup identifier'), feature_subgroup_desc
OPTIONS(description='Feature subgroup description'), feature_group_id OPTIONS(description='Feature_group identifier'),
active_fg OPTIONS(description='Activity Flag'), dwh_load_id OPTIONS(description='Load identifier'), dwh_created
OPTIONS(description='Row insert time'), dwh_updated OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `LIDL PLUS FEATURE SUBGROUP`) AS SELECT feature_subgroup_id,
 feature_subgroup_desc,
 feature_group_id,
 active_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_ref_ldpl_feature_subgroup_2;