/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_mat_apt_subitemgroup
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_apt_subitemgroup (client_id, country_iso_cd, dwh_valid_from, dwh_valid_to
, subitemgroup_cd, mainitemgroup_cd, int_itemgroup_cd, dwh_updated, dwh_created, dwh_load_id, load_id, src_id) AS SELECT
 client_id,
 country_iso_cd,
 dwh_valid_from,
 dwh_valid_to,
 subitemgroup_cd,
 mainitemgroup_cd,
 int_itemgroup_cd,
 dwh_updated,
 dwh_created,
 dwh_load_id,
 CAST(- 1 AS BIGNUMERIC) AS load_id,
 2 AS src_id
FROM ldl_p_lew_mart_cs.v_cs_subitemgroup
GROUP BY client_id,
 country_iso_cd,
 dwh_valid_from,
 dwh_valid_to,
 subitemgroup_cd,
 mainitemgroup_cd,
 int_itemgroup_cd,
 dwh_updated,
 dwh_created,
 dwh_load_id,
 load_id,
 src_id;