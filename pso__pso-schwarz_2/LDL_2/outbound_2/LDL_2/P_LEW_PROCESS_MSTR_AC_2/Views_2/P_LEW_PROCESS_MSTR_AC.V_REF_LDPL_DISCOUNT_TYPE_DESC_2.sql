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


CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ref_ldpl_discount_type_desc_2 (discount_type_id
OPTIONS(description='Discount type identifier'), discount_type_desc
OPTIONS(description='Discount type description per language'), lang_cd OPTIONS(description='Language code'), dwh_load_id
OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row insert time'), dwh_updated
OPTIONS(description='Row update time')) OPTIONS(DESCRIPTION = `LIDL PLUS DISCOUNT TYPE DESCRIPTION`) AS SELECT *
FROM ldl_p_lew_process_mstr.v_ref_ldpl_discount_type_desc_2;