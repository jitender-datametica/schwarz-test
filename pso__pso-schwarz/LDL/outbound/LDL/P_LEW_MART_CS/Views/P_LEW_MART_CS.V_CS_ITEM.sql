/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_CS_ITEM
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  22.09.2021    Ross, Ulrich                 Add group by while changing v_mat_gen_item_asis for ItemStatus_cd because it was missing on CLOUD
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_cs_item (client_id, orig_item_nr, case_size, orig_item_nr_int, country_iso_cd
, is_plu_item, buying_list_type_id, plu_nr, unitsize, dwh_updated, dwh_created, dwh_load_id) AS SELECT client_id,
 orig_item_nr,
 case_size,
 orig_item_nr_int,
 src_country_lidl_cd AS country_iso_cd,
  CASE
  WHEN case_plu_fg > 0
  THEN 1
  ELSE 0
  END AS is_plu_item,
 buying_list_type_id,
 plu_nr,
 unitsize,
 dwh_updated,
 dwh_created,
 dwh_load_id
FROM ldl_p_lew_mart_cs.v_gen_item_asis AS I
GROUP BY client_id,
 orig_item_nr,
 case_size,
 orig_item_nr_int,
 country_iso_cd,
 is_plu_item,
 buying_list_type_id,
 plu_nr,
 unitsize,
 dwh_updated,
 dwh_created,
 dwh_load_id;