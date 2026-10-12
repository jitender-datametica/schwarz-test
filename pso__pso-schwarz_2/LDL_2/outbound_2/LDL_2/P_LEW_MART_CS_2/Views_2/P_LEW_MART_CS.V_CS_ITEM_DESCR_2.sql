/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_cs_item_descr_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  17.03.2021    Guenes, Oguzhan              CloudMig FS - APT Nachfolgepatch 4 TD: Änderungen in SNFLK 
#                                                  https://jira.schwarz/browse/DDLE-1994
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_cs_item_descr_2 (client_id, item_id, orig_item_nr, case_size,
item_descr_type_id, valid_from, valid_until, item_descr, country_iso_cd, language_id, language_iso_cd, itemstatus_cd,
buying_list_type_id, dwh_updated, dwh_created, dwh_load_id) AS SELECT i.client_id,
 i.item_sid AS item_id,
 i.orig_item_nr,
 i.case_size,
 1 AS item_descr_type_id,
  CASE
  WHEN i.valid_from > DATE(COALESCE(DESCR.dwh_created, DESCR_SAMMEL.dwh_created))
  THEN i.valid_from
  ELSE DATE(COALESCE(DESCR.dwh_created, DESCR_SAMMEL.dwh_created))
  END AS valid_from,
 i.valid_until,
 COALESCE(DESCR_SAMMEL.item_descr, DESCR.item_descr) AS item_descr,
 CLI.src_country_lidl_cd AS country_iso_cd,
 LANG.language_id,
 LANG.language_iso_cd,
 i.itemstatus_cd,
 i.buying_list_type_id,
 DESCR.dwh_updated,
 DESCR.dwh_created,
 DESCR.dwh_load_id
FROM (SELECT client_id,
   orig_item_nr,
   case_size,
   item_sid,
   item_sid_config,
   MIN(valid_from) AS valid_from,
   MAX(valid_until) AS valid_until,
   itemstatus_cd,
   buying_list_type_id
  FROM ldl_p_lew_mart_cs.v_gen_item_asis_2
  GROUP BY client_id,
   item_sid,
   item_sid_config,
   orig_item_nr,
   case_size,
   itemstatus_cd,
   buying_list_type_id) AS i
 INNER JOIN ldl_p_lew_core_ac.v_item_hist_2 AS ITM_H ON i.client_id = ITM_H.client_id AND i.item_sid = ITM_H.item_sid AND
    ITM_H.deleted_fg = 0 AND CURRENT_DATE BETWEEN ITM_H.dwh_valid_from AND ITM_H.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_client_2 AS CLI ON i.client_id = CLI.client_id
 INNER JOIN ldl_p_lew_core_ac.v_country_2 AS CTRY ON CLI.country_sid = CTRY.country_sid OR CTRY.src_country_lidl_cd =
   'INTEGER '
 INNER JOIN ldl_p_lew_core_ac.v_report_language_2 AS RLANG ON CTRY.lang_sid = RLANG.lang_sid
 INNER JOIN ldl_p_lew_core_ac.v_map_lang_spras_2 AS LANG ON TRIM(LANG.sap_lang_cd) = TRIM(RLANG.iso_cd)
 INNER JOIN ldl_p_lew_core_ac.v_item_descr_2 AS DESCR ON i.client_id = DESCR.client_id AND i.item_sid = DESCR.item_sid AND
   RLANG.lang_sid = DESCR.lang_sid
 LEFT JOIN ldl_p_lew_core_ac.v_item_2 AS ITM_S ON i.client_id = ITM_S.client_id AND i.item_sid_config = ITM_S.item_sid
 LEFT JOIN ldl_p_lew_core_ac.v_item_descr_2 AS DESCR_SAMMEL ON i.client_id = DESCR_SAMMEL.client_id AND ITM_S.item_sid =
    DESCR_SAMMEL.item_sid AND RLANG.lang_sid = DESCR_SAMMEL.lang_sid;