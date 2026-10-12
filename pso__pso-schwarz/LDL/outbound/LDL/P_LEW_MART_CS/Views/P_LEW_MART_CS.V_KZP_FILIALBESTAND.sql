/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS.V_KZP_FILIALBESTAND
#----------------------------------------------------------------------------
# History:
#  1.0  01.10.2020    Ulrich Ross            Init KZP
#  1.1  11.03.2021    Ulrich Ross            Add aggregation for quantities and alter GROUP BY to remove multiple rows for items with differnt cas_size
#  1.2  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.3  17.03.2021    Guenes, Oguzhan          CloudMig FS - KZP Nachfolgepatch 3 TD: Änderungen in SNFLK
#                                              https://jira.schwarz/browse/DDLE-1995
#  1.4  12.05.2021    Ross, Ulrich            Remove Aggregation and add sub-select to remove duplicate rows.
#  1.5  24.06.2021    Ross, Ulrich            Remove deleted_fg in subSelect for v_gen_item_hist to get all items 
#  1.6  09.11.2021    Ross, Ulrich            Remove timeline logic for attribut valid_to.  https://jira.schwarz/browse/DDLE-2778
#  1.7  28.02.2022    Ross, Ulrich            Remove 90 days backward where clause; UserStory 292052
#  1.8  30.03.2022    Ross, Ulrich            Fix missing Filialbestand while stores closed; User Story 306764
#----------------------------------------------------------------------------
*/



CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_kzp_filialbestand (client_id, country_iso_cd, orig_item_nr, src_orig_store_nr
, calc_qty, inv_qty, diff_qty_inv_calc, valid_from, valid_to, load_id, dwh_created, timestamp_delta)
OPTIONS(DESCRIPTION = `$Revision: 16943 $ `) AS -- Country
 SELECT VILSH.client_id,
 T.src_country_lidl_cd AS country_iso_cd,
 item.orig_item_nr,
 store.src_orig_store_nr,
 VILSH.calc_qty,
 VILSH.inv_qty,
 VILSH.diff_qty_inv_calc,
 VILSH.dwh_valid_from AS valid_from,
 VILSH.dwh_valid_to AS valid_to,
 VILSH.dwh_load_id AS load_id,
 VILSH.dwh_created,
 VILSH.dwh_updated AS timestamp_delta
FROM ldl_p_lew_core_ac.v_item_location_stock_hist AS VILSH
 INNER JOIN ldl_p_lew_core_ac.v_client AS C ON VILSH.client_id = C.client_id
 INNER JOIN ldl_p_lew_core_ac.v_country AS T ON C.country_sid = T.country_sid
 LEFT JOIN (SELECT client_id,
   item_sid,
   orig_item_nr
  FROM ldl_p_lew_mart_cs.v_gen_item_hist
  WHERE DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN valid_from AND valid_until
  GROUP BY client_id,
   item_sid,
   orig_item_nr) AS item ON VILSH.client_id = item.client_id AND VILSH.item_sid = item.item_sid
 INNER JOIN (SELECT client_id,
   loc_sid_store,
   src_orig_store_nr
  FROM ldl_p_lew_mart_cs.v_gen_kzp_store
  WHERE src_wh_id <> src_orig_store_nr
  GROUP BY client_id,
   loc_sid_store,
   src_orig_store_nr) AS store ON VILSH.client_id = store.client_id AND VILSH.loc_sid = store.loc_sid_store
WHERE item.orig_item_nr IS NOT NULL
 AND store.src_orig_store_nr IS NOT NULL;


