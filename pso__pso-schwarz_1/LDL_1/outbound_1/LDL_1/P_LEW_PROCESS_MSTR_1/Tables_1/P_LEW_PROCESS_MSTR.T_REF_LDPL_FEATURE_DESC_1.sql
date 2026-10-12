/*
#----------------------------------------------------------------------------
# Feature Description
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-06 Pawel Wieczorek          SD-2524 Initial version
#
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_ref_ldpl_feature_desc_1 (
feature_id BIGNUMERIC(38,0) NOT NULL,
lang_cd STRING(20) NOT NULL,
feature_desc STRING(250) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (feature_id, lang_cd) NOT ENFORCED
);