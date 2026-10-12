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


CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_group_desc_2 (coupon_type_group_id
OPTIONS(description='Coupon type group identifier'), coupon_type_group_desc
OPTIONS(description='Coupon type group description per language'), lang_cd OPTIONS(description='Language code'),
dwh_load_id OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row insert time'), dwh_updated
OPTIONS(description='Row update time')) OPTIONS(DESCRIPTION = `LIDL PLUS COUPON TYPE GROUP DESCRIPTION`) AS SELECT *
FROM ldl_p_lew_process_mstr.v_ref_ldpl_coupon_type_group_desc_2;