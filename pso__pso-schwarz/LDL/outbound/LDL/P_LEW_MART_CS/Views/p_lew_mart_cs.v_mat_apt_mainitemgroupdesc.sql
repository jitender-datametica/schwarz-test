/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_mat_apt_mainitemgroupdesc
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_apt_mainitemgroupdesc (client_id, country_iso_cd, dat_valid_from,
dat_valid_to, mainitemgroup_id, language_iso_cd, main_item_grp_name, dwh_updated, dwh_created, dwh_load_id, load_id,
src_id) AS SELECT A.client_id,
 T.src_country_lidl_cd AS country_iso_cd,
 A.dwh_created AS dat_valid_from,
 DATE '9999-12-31' AS dat_valid_to,
 A.src_mainitemgrp_id AS mainitemgroup_id,
 L.language_iso_cd,
 A.main_item_grp_name,
 A.dwh_updated,
 A.dwh_created,
 A.dwh_load_id,
 CAST(- 1 AS BIGNUMERIC) AS load_id,
 2 AS src_id
FROM ldl_p_lew_core_ac.v_mainitemgroup AS A
 INNER JOIN ldl_p_lew_core_ac.v_client AS C ON A.client_id = C.client_id
 INNER JOIN ldl_p_lew_core_ac.v_country AS T ON C.country_sid = T.country_sid
 INNER JOIN ldl_p_lew_core_ac.v_map_lang_spras AS L ON T.lang_cd = L.sap_lang_cd AND (L.sap_lang_cd = '@' OR A.client_id
      = L.language_id);