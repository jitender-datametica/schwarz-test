/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_apt_item_subitemgrp_rel
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_apt_item_subitemgrp_rel (client_id, country_iso_cd, org_item_nr, valid_from,
case_size, dat_rec_start, dat_rec_end, subitemgroup_no, cs_updated, cs_created, cs_load_id) AS SELECT client_id,
 country_iso_cd,
 org_item_nr,
 valid_from,
 case_size,
 dat_rec_start,
 dat_rec_end,
 subitemgroup_no,
 cs_updated,
 cs_created,
 cs_load_id
FROM ldl_p_lew_mart_cs.t_apt_item_subitemgrp_rel AS A;