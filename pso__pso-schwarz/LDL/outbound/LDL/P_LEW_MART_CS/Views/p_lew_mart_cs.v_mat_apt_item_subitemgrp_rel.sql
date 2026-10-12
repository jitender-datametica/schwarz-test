/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_MAT_APT_ITEM_SUBITEMGRP_REL
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_apt_item_subitemgrp_rel (client_id, country_iso_cd, org_item_nr,
valid_from, case_size, dat_rec_start, dat_rec_end, subitemgroup_no, dwh_updated, dwh_created, dwh_load_id, load_id,
src_id) AS SELECT client_id,
 src_country_lidl_cd AS country_iso_cd,
 orig_item_nr AS org_item_nr,
 valid_from,
 COALESCE(case_size, 0) AS case_size,
 valid_from AS dat_rec_start,
 valid_until AS dat_rec_end,
 subitemgroup_id AS subitemgroup_no,
 dwh_updated,
 dwh_created,
 dwh_load_id,
 CAST(- 1 AS BIGNUMERIC) AS load_id,
 2 AS src_id
FROM ldl_p_lew_mart_cs.v_gen_item_asis AS A
WHERE subitemgroup_id > 0
 AND (itemstatus_cd > 3 AND itemstatus_cd < 10)
 AND buying_list_type_id > 0
GROUP BY client_id,
 country_iso_cd,
 org_item_nr,
 valid_from,
 A.case_size,
 dat_rec_start,
 dat_rec_end,
 subitemgroup_no,
 dwh_updated,
 dwh_created,
 dwh_load_id,
 load_id,
 src_id
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), org_item_nr, valid_from, CAST(case_size AS STRING)
    ORDER BY subitemgroup_no IS NULL, subitemgroup_no)) = 1;