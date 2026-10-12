/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_cs_subitemgroup_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_cs_subitemgroup_2 (client_id, subitemgroup_sid, subitemgroup_cd,
mainitemgroup_cd, int_itemgroup_cd, language_id, language_iso_cd, country_iso_cd, descr_short, descr_long,
dwh_valid_from, dwh_valid_to, dwh_updated, dwh_created, dwh_load_id) AS SELECT A.client_id,
 A.sub_item_grp_sid AS subitemgroup_sid,
 A.src_subitemgrp_cd AS subitemgroup_cd,
 B.main_item_grp_cd AS mainitemgroup_cd,
 B.item_grp_int_cd AS int_itemgroup_cd,
 D.language_id,
 D.language_iso_cd,
 T.src_country_lidl_cd AS country_iso_cd,
 C.sub_item_grp_descr AS descr_short,
 C.sub_item_grp_descr AS descr_long,
 B.dwh_valid_from,
 B.dwh_valid_to,
 B.dwh_updated,
 B.dwh_created,
 B.dwh_load_id
FROM ldl_p_lew_core_ac.v_subitemgroup_2 AS A
 INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_hist_2 AS B ON A.client_id = B.client_id AND A.sub_item_grp_sid = B.sub_item_grp_sid
     AND CURRENT_DATE BETWEEN B.dwh_valid_from AND B.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_descr_2 AS C ON A.client_id = C.client_id AND A.sub_item_grp_sid = C.sub_item_grp_sid
   
 INNER JOIN ldl_p_lew_core_ac.v_map_lang_spras_2 AS D ON C.lang_cd = D.sap_lang_cd AND (D.sap_lang_cd = '@' OR C.client_id
      = D.language_id)
 INNER JOIN ldl_p_lew_core_ac.v_client_2 AS CL ON A.client_id = CL.client_id
 INNER JOIN ldl_p_lew_core_ac.v_country_2 AS T ON CL.country_sid = T.country_sid;