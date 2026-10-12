/*
#----------------------------------------------------------------------------
# Coupon Type
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.1 2024-05-21 Marcin Kikoła            AP0206303 Introduction of Loyalty_attribute
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_process_mstr.v_ref_ldpl_feature_group_loyalty_2 (loyalty_id
OPTIONS(description='Loyalty attribute identifier'), loyalty_desc OPTIONS(description='Loyalty attribute description'),
dwh_load_id OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row insert time'), dwh_updated
OPTIONS(description='Row update time')) OPTIONS(DESCRIPTION = `LIDL PLUS LOYALTY`) AS SELECT loyalty_id,
 loyalty_desc,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_ref_ldpl_feature_group_loyalty_2;