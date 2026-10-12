/*
#----------------------------------------------------------------------------
# Coupon Type Group
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-06 Pawel Wieczorek          SD-2524 Initial version
#
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_ref_ldpl_coupon_type_group_2 (
coupon_type_group_id BIGNUMERIC(38,0) NOT NULL,
coupon_type_group_desc STRING(250) NOT NULL,
active_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
dwh_load_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (coupon_type_group_id) NOT ENFORCED
);