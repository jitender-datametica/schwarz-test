/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_CS_ITEM_WH_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  23.09.2021    Ross, Ulrich                 Add group by while changing v_mat_gen_item_asis_2 for ItemStatus_cd
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_cs_item_wh_2 (client_id, wh_id, orig_item_nr, case_size, country_iso_cd,
dwh_valid_from, dwh_valid_to, item_status_id, dwh_updated, dwh_created, dwh_load_id) AS SELECT I.client_id,
 IWH.wh_id,
 I.orig_item_nr,
 I.case_size,
 I.src_country_lidl_cd AS country_iso_cd,
 IWH.dwh_valid_from,
 IWH.dwh_valid_to,
 IWH.item_status_id,
 IWH.dwh_updated,
 IWH.dwh_created,
 IWH.dwh_load_id
FROM ldl_p_lew_mart_cs.v_gen_item_wh_2 AS IWH
 INNER JOIN ldl_p_lew_mart_cs.v_gen_item_asis_2 AS I ON IWH.client_id = I.client_id AND IWH.item_sid = I.item_sid
GROUP BY I.client_id,
 IWH.wh_id,
 I.orig_item_nr,
 I.case_size,
 country_iso_cd,
 IWH.dwh_valid_from,
 IWH.dwh_valid_to,
 IWH.item_status_id,
 IWH.dwh_updated,
 IWH.dwh_created,
 IWH.dwh_load_id;