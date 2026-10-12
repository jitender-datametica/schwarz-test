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


CREATE OR REPLACE VIEW ldl_p_lew_process_mstr.v_ref_ldpl_feature_subgroup_desc_2 (feature_subgroup_id
OPTIONS(description='Feature subgroup identifier'), feature_subgroup_desc
OPTIONS(description='Feature subgroup description per language'), lang_cd OPTIONS(description='Language code'),
dwh_load_id OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row insert time'), dwh_updated
OPTIONS(description='Row update time')) OPTIONS(DESCRIPTION = `LIDL PLUS FEATURE SUBGROUP DESCRIPTION`) AS SELECT
 feature_subgroup_id,
 feature_subgroup_desc,
 lang_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_ref_ldpl_feature_subgroup_desc_2;