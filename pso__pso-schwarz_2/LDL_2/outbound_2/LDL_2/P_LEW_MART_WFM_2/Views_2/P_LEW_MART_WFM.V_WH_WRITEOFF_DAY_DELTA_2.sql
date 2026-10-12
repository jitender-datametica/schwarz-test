/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_STORE_WRITEOFF_DAY_DELTA_2
#----------------------------------------------------------------------------
# History:
#  1.0  2023-06-12    Ulrich ross          Remove eLWIS logic
#                                          https://dev.azure.com/schwarzit/schwarzit.biaid/_boards/board/t/Data%20Extraction%20And%20Export/Stories/?workitem=488527
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_wh_writeoff_day_delta_2 AS
/* CHANGE V_LOCATION_2 TO STORE_TO_WAREHOUSE_LASTKNOWN */ /* CLIENTAUFLOESUNG */ /* DELTALOGIK */ SELECT t4.client_ AS
 client_id,
 t4.land_ AS country_lidl_cd,
 t4.wh_id,
 t4.receiptdate,
 t4.item_2,
 ROUND(CAST(SUM(t4.a0_0 * - 1) AS NUMERIC), 3) AS writeoff_value_net,
 CAST(SUM(t4.a0 * - 1) AS NUMERIC) AS writeoff_pieces,
 t4.storeform_type_ AS storeform_type,
 t4.writeoff_zero_fg_ AS writeoff_zero_fg,
 MAX(t4.load_id) AS load_id
FROM (SELECT ITM_MOV.sfo_type_id AS storeform_type_,
   ITM_MOV.client_id AS client_,
   CLIENTS.src_country_lidl_cd AS land_,
   LOC.src_wh_id AS wh_id,
   LOC.src_orig_store_nr AS store,
   ITM_MOV.dwh_cal_dt AS receiptdate,
   ROUND(CAST(ITEM0.src_orig_item_nr AS BIGNUMERIC), 0) AS item_2,
   ITEM0.src_case_size AS inhaltkolli,
   ITM_MOV.wh_gross_price AS wertstck,
    CASE
    WHEN ITM_MOV.wh_gross_price <> 0 AND ITM_MOV.new_gross_price = 0 OR ITM_MOV.wh_gross_price = 0 AND ITM_MOV.new_gross_price
        <> 0
    THEN 1
    ELSE 0
    END AS writeoff_zero_fg_,
   SUM(ITM_MOV.case_qty) AS mengekolli,
   SUM(CASE
     WHEN ITM_MOV.piece_qty IS NULL
     THEN 0
     ELSE ITM_MOV.piece_qty
     END) AS mengestck,
   SUM(ITM_MOV.total_qty) AS a0,
   SUM(ITM_MOV.receipt_line_net_val) AS a0_0,
   MAX(ITM_MOV.dwh_load_id) AS load_id
  FROM ldl_p_lew_core_ac.v_store_form_2 AS ITM_MOV
   INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_2 AS LOC ON ITM_MOV.loc_sid_store = LOC.loc_sid_store AND
       ITM_MOV.client_id = LOC.client_id AND ITM_MOV.loc_sid_wh_to = LOC.loc_sid_wh AND LOC.active_fg = 1
   INNER JOIN ldl_p_lew_core_ac.v_item_2 AS ITEM0 ON ITM_MOV.item_sid = ITEM0.item_sid AND ITM_MOV.client_id = ITEM0.client_id
     
   INNER JOIN ldl_p_lew_core_ac.v_client_2 AS CLIENTS ON ITM_MOV.client_id = CLIENTS.client_id
   INNER JOIN (SELECT ITM_MOV0.client_id,
     ITM_MOV0.loc_sid_store,
     ITM_MOV0.dwh_cal_dt
    FROM ldl_p_lew_core_ac.v_store_form_2 AS ITM_MOV0
     INNER JOIN ldl_p_lew_process_ac.v_wfm_last_export_2 AS LAST_EXPO ON ITM_MOV0.dwh_updated > LAST_EXPO.last_export_tmsp
           AND LAST_EXPO.process_name = 'export_wfm_wh_writeoff_day' AND LAST_EXPO.process_specification = 'delta' AND
        ITM_MOV0.dwh_cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 40 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
         ) AND ITM_MOV0.sfo_type_id IN (181, 182, 191, 192)
     INNER JOIN ldl_p_lew_process_ac.v_wfm_export_specification_2 AS EXPO_SPEC ON LAST_EXPO.export_specification =
       EXPO_SPEC.export_specification AND ITM_MOV0.client_id = EXPO_SPEC.client_id
    GROUP BY ITM_MOV0.client_id,
     ITM_MOV0.loc_sid_store,
     ITM_MOV0.dwh_cal_dt) AS delta_filter ON ITM_MOV.client_id = delta_filter.client_id AND ITM_MOV.loc_sid_store =
      delta_filter.loc_sid_store AND ITM_MOV.dwh_cal_dt = delta_filter.dwh_cal_dt
  WHERE ITM_MOV.sfo_type_id IN (181, 182, 191, 192)
  GROUP BY storeform_type_,
   client_,
   land_,
   wh_id,
   store,
   receiptdate,
   item_2,
   inhaltkolli,
   wertstck,
   writeoff_zero_fg_) AS t4
GROUP BY client_id,
 country_lidl_cd,
 t4.wh_id,
 t4.receiptdate,
 t4.item_2,
 storeform_type,
 writeoff_zero_fg;