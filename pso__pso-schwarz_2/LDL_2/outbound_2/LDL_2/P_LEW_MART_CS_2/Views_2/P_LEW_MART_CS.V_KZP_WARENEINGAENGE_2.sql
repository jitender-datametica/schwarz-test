/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_KZP_WARENEINGAENGE_2
#----------------------------------------------------------------------------
# History:
When       Who                   What
#  1.0  17.12.2019    Wieber.Harald            Init KZP
#  1.1  19.12.2019    Wieber,Harald            Update
#  1.2  09.03.2020    Kunz,Gernot              20200129_2358_Update_25_Mart_CS_DWH20
#                                              Add "delta" columns
#  1.3  26.02.2021    Ross, Ulrich             Add time filter in view v_gen_item_hist_2 
#  1.4  10.03.2021    Ross, Ulrich             Change column retail_net_fa_val to retail_net_val and buying_fa_val to buying_val
#  1.5  15.03.2021    Guenes, Oguzhan          Transfer to Snowflake.
#                                              https://jira.schwarz/browse/DDLE-1783
#                                              Create scripts for snowflake standardisation.
#  1.6  17.03.2021    Guenes, Oguzhan          CloudMig FS - KZP Nachfolgepatch 3 TD: Änderungen in SNFLK
#                                              https://jira.schwarz/browse/DDLE-1995
#  1.7  24.06.2021    Ross, Ulrich             Remove deleted_fg in subSelect for v_gen_item_hist_2 to get all items 
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_kzp_wareneingaenge_2 (client_id, country_iso_cd, wh_id, orig_item_nr,
dat_formdate, dat_entry_rcv, val_net_retail, val_buying_rcv, receipt_pos_margin_rel_fg, receipt_type_id, currency_iso_cd
, item_valid_from, item_valid_until, load_id, timestamp_delta) AS SELECT RECV.client_id,
 T.src_country_lidl_cd AS country_iso_cd,
 RECV.src_wh_id AS wh_id,
 COALESCE(item.orig_item_nr, - 1) AS orig_item_nr,
 RECV.dwh_cal_dt AS dat_formdate,
 MIN(RECV.entry_dt) AS dat_entry_rcv,
 ROUND(CAST(SUM(RECV.retail_net_val) AS NUMERIC), 4) AS val_net_retail,
 ROUND(CAST(SUM(RECV.buying_val) AS NUMERIC), 4) AS val_buying_rcv,
 RECV.receipt_pos_margin_rel_fg,
 RECV.receipt_type_id,
 RECV.curr_cd_from AS currency_iso_cd,
 item.valid_from AS item_valid_from,
 item.valid_until AS item_valid_until,
 MAX(RECV.dwh_load_id) AS load_id,
 MAX(RECV.dwh_created) AS timestamp_delta
FROM ldl_p_lew_bil_ac.v_mov_item_receive_wh_2 AS RECV
 INNER JOIN ldl_p_lew_core_ac.v_client_2 AS C ON RECV.client_id = C.client_id
 INNER JOIN ldl_p_lew_core_ac.v_country_2 AS T ON C.country_sid = T.country_sid
 LEFT JOIN (SELECT client_id,
   item_sid,
   valid_from,
   valid_until,
   orig_item_nr
  FROM ldl_p_lew_mart_cs.v_gen_item_hist_2
  WHERE DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN valid_from AND valid_until
  GROUP BY client_id,
   item_sid,
   valid_from,
   valid_until,
   orig_item_nr) AS item_2 ON RECV.client_id = item.client_id AND RECV.item_sid = item.item_sid
GROUP BY RECV.client_id,
 country_iso_cd,
 wh_id,
 orig_item_nr,
 dat_formdate,
 RECV.receipt_pos_margin_rel_fg,
 RECV.receipt_type_id,
 currency_iso_cd,
 item_valid_from,
 item_valid_until;