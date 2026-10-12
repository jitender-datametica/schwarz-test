/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_CS_SUBITEMGRP_NAT
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_cs_subitemgrp_nat (client_id, src_subitemgrp_cd, language_id, valid_from,
valid_until, sortkey, descr_short, descr_long, last_refresh) AS SELECT A.client_id,
 A.src_subitemgrp_cd,
 D.language_id,
 B.dwh_valid_from AS valid_from,
 DATE '9999-12-31' AS valid_until,
 CAST(NULL AS BIGNUMERIC) AS sortkey,
 C.sub_item_grp_descr AS descr_short,
 C.sub_item_grp_descr AS descr_long,
 CURRENT_DATE AS last_refresh
FROM ldl_p_lew_core_ac.v_subitemgroup AS A
 INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_hist AS B ON A.client_id = B.client_id AND A.sub_item_grp_sid = B.sub_item_grp_sid
     AND CURRENT_DATE BETWEEN B.dwh_valid_from AND B.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_descr AS C ON A.client_id = C.client_id AND A.sub_item_grp_sid = C.sub_item_grp_sid
   
 INNER JOIN ldl_p_lew_core_ac.v_map_lang_spras AS D ON C.lang_cd = D.sap_lang_cd AND (D.sap_lang_cd = '@' OR C.client_id
      = D.language_id);