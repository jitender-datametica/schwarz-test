/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_MAT_APT_ITEM_FAMILYGRP_ITEM_REL_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  22.09.2021    Ulrich, Ross                 Deliver only itemstatus_cd 4,5,6,7,8,9 and add filter for buying_list_type_id; Was missing on CLOUD
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_apt_item_familygrp_item_rel_1 (client_id, country_iso_cd, org_item_nr,
valid_from, case_size, dat_rec_start, dat_rec_end, item_familygroup_id, dwh_updated, dwh_created, dwh_load_id, load_id,
src_id) AS SELECT client_id,
 src_country_lidl_cd AS country_iso_cd,
 orig_item_nr AS org_item_nr,
 valid_from,
 COALESCE(case_size, 1) AS case_size,
 valid_from AS dat_rec_start,
 valid_until AS dat_rec_end,
 item_familygroup_id,
 dwh_updated,
 dwh_created,
 dwh_load_id,
 CAST(TRUNC(- 1) AS BIGNUMERIC) AS load_id,
 2 AS src_id
FROM ldl_p_lew_mart_cs.v_gen_item_asis_1 AS A
WHERE item_familygroup_id <> 0
 AND (itemstatus_cd > 3 AND itemstatus_cd < 10)
 AND buying_list_type_id > 0
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), orig_item_nr, valid_from, CAST(case_size AS STRING)
    ORDER BY item_familygroup_id IS NULL, item_familygroup_id)) = 1;