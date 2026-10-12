/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-05 Pawel Wieczork          SD-2524 Initial version
#
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_ref_ldpl_discount_type_1 (
discount_type_id BIGNUMERIC(38,0) NOT NULL,
discount_type_desc STRING(250) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (discount_type_id) NOT ENFORCED
);