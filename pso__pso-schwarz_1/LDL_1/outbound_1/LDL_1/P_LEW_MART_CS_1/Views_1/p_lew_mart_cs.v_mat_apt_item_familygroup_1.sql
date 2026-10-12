/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_mat_apt_item_familygroup_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_apt_item_familygroup_1 (client_id, country_iso_cd, dat_rec_start,
dat_rec_end, item_familygroup_id, subitemgroup_id, itemfamily_cd, dwh_updated, dwh_created, dwh_load_id, load_id, src_id
) AS SELECT client_id,
 src_country_lidl_cd AS country_iso_cd,
 dat_rec_start,
 dat_rec_end,
 item_familygroup_id,
 subitemgroup_id,
 itemfamily_cd,
 dwh_updated,
 dwh_created,
 dwh_load_id,
 load_id,
 src_id
FROM ldl_p_lew_mart_cs.v_gen_item_family_1 AS A
WHERE item_familygroup_id > 0
 AND subitemgroup_id > 0
GROUP BY client_id,
 country_iso_cd,
 dat_rec_start,
 dat_rec_end,
 item_familygroup_id,
 subitemgroup_id,
 itemfamily_cd,
 dwh_updated,
 dwh_created,
 dwh_load_id,
 load_id,
 src_id;