/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_STORE_DELIVERY_DELTA_2
#----------------------------------------------------------------------------
# History:
#  1.0  2023-06-12    Ulrich ross          Remove eLWIS logic
#                                          https://dev.azure.com/schwarzit/schwarzit.biaid/_boards/board/t/Data%20Extraction%20And%20Export/Stories/?workitem=488527
#  1.0  2023-07-17    Ulrich ross          Bugfix column name
#                                          https://dev.azure.com/schwarzit/schwarzit.biaid/_boards/board/t/Data%20Extraction%20And%20Export/Stories/?workitem=503083
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_store_delivery_delta_2 AS /* timestamp delta with key logic */
-- qty_case_order       in first select
 -- qty_piece_act_del    in first select
 /* timestamp delta with key logic */
-- qty_case_order        in first select
 -- qty_piece_del         in first select

-- qty_piece_act_del     in first select
 /* timestamp delta with key logic */ SELECT client_id,
 country_lidl_cd,
 store,
 receiptdate,
 item_2,
 ROUND(CAST(SUM(sum_qty_piece) AS NUMERIC), 5) AS qty_piece_del,
 ROUND(CAST(SUM(sum_qty_kolli) AS NUMERIC), 5) AS qty_case_del,
 MIN(case_size_real) AS case_size_real,
 MIN(is_multiple_case_size) AS is_multiple_case_size,
 CAST(SUM(sum_qty_piece_real) AS NUMERIC) AS qty_piece_del_real,
 ROUND(CAST(SUM(sum_qty_kolli_real) AS NUMERIC), 5) AS qty_case_del_real,
 MAX(load_id) AS load_id
FROM (SELECT inner_unions.client_id,
   CLIENTS.src_country_lidl_cd AS country_lidl_cd,
   LOC.src_orig_store_nr AS store,
   inner_unions.dat_formdate AS receiptdate,
   ROUND(CAST(ITEM0.src_orig_item_nr AS BIGNUMERIC), 0) AS item_2,
   CAST(CASE
       WHEN inner_unions.deliverytype_id = 1
       THEN CAST(inner_unions.qty_case_order AS BIGNUMERIC)
       ELSE CAST(inner_unions.qty_case_del AS BIGNUMERIC)
       END * CASE
       WHEN ROUND(CAST(ITEM0.src_case_size AS NUMERIC), 2) = - 1
       THEN CAST(SKEY_ACT.case_size AS NUMERIC)
       ELSE ROUND(CAST(ITEM0.src_case_size AS NUMERIC), 2)
       END + CASE
      WHEN inner_unions.deliverytype_id IN (1, 3)
      THEN CAST(inner_unions.qty_piece_del AS BIGNUMERIC)
      ELSE 0.00000
      END AS BIGNUMERIC) AS sum_qty_piece,
   CAST(CASE
      WHEN inner_unions.deliverytype_id = 1
      THEN CAST(inner_unions.qty_case_order AS BIGNUMERIC)
      ELSE CAST(inner_unions.qty_case_del AS BIGNUMERIC)
      END + CASE
       WHEN inner_unions.deliverytype_id IN (1, 3)
       THEN CAST(inner_unions.qty_piece_del AS BIGNUMERIC)
       ELSE 0.00000
       END / COALESCE(CASE
        WHEN ROUND(CAST(ITEM0.src_case_size AS NUMERIC), 2) = - 1
        THEN CAST(SKEY_ACT.case_size AS NUMERIC)
        ELSE ROUND(CAST(ITEM0.src_case_size AS NUMERIC), 2)
        END, 1) AS BIGNUMERIC) AS sum_qty_kolli,
   ROUND(CAST(MIN(inner_unions.case_size_real) OVER (PARTITION BY CAST(inner_unions.client_id AS STRING), CAST(inner_unions.item_sid AS STRING)
        , CAST(inner_unions.st_loc_sid AS STRING), inner_unions.dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING) AS NUMERIC), 5) AS case_size_real,
    CASE
    WHEN (MIN(inner_unions.case_size_real) OVER (PARTITION BY CAST(inner_unions.client_id AS STRING), CAST(inner_unions.item_sid AS STRING)
         , CAST(inner_unions.st_loc_sid AS STRING), inner_unions.dat_formdate RANGE BETWEEN UNBOUNDED PRECEDING AND
       UNBOUNDED FOLLOWING)) <> (MAX(inner_unions.case_size_real) OVER (PARTITION BY CAST(inner_unions.client_id AS STRING)
         , CAST(inner_unions.item_sid AS STRING), CAST(inner_unions.st_loc_sid AS STRING), inner_unions.dat_formdate
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
    THEN 1
    ELSE 0
    END AS is_multiple_case_size,
    CASE
    WHEN inner_unions.from_fvm = 1
    THEN ROUND(CAST(CASE
         WHEN inner_unions.deliverytype_id = 1
         THEN CAST(inner_unions.qty_case_order AS BIGNUMERIC)
         ELSE CAST(inner_unions.qty_case_del AS BIGNUMERIC)
         END * inner_unions.case_size_real + CASE
        WHEN inner_unions.deliverytype_id IN (1, 3)
        THEN CAST(inner_unions.qty_piece_del AS BIGNUMERIC)
        ELSE 0.00000
        END AS NUMERIC), 5)
    ELSE NULL
    END AS sum_qty_piece_real,
    CASE
    WHEN inner_unions.from_fvm = 1
    THEN CAST(CASE
       WHEN inner_unions.deliverytype_id = 1
       THEN CAST(inner_unions.qty_case_order AS BIGNUMERIC)
       ELSE CAST(inner_unions.qty_case_del AS BIGNUMERIC)
       END + CASE
        WHEN inner_unions.deliverytype_id IN (1, 3)
        THEN CAST(inner_unions.qty_piece_del AS BIGNUMERIC)
        ELSE 0.00000
        END / COALESCE(CASE
         WHEN inner_unions.case_size_real = 0
         THEN NULL
         ELSE inner_unions.case_size_real
         END, 1) AS BIGNUMERIC)
    ELSE NULL
    END AS sum_qty_kolli_real,
   inner_unions.load_id
  FROM (SELECT MOV.client_id,
      MOV.item_sid,
      MOV.dwh_cal_dt AS dat_formdate,
      MOV.receipt_id AS receipt_id_del,
      MOV.loc_sid_store AS st_loc_sid,
      MOV.loc_sid_wh AS wh_loc_sid,
      MOV.vat_id,
      MOV.order_area_cd,
      MOV.dayend_dt AS dat_dayend,
      MOV.delivery_type_id AS deliverytype_id,
      MOV.del_case_qty AS qty_case_del,
      MOV.ordered_case_qty AS qty_case_order,
      MOV.del_piece_qty AS qty_piece_del,
      MOV.act_del_piece_qty AS qty_piece_act_del,
      CAST(NULL AS NUMERIC) AS case_size_real,
      0 AS from_fvm,
      MOV.dwh_load_id AS load_id
     FROM ldl_p_lew_core_ac.v_item_delivery_2 AS MOV
      INNER JOIN (SELECT MOV_DELTA.client_id,
        MOV_DELTA.item_sid,
        MOV_DELTA.dwh_cal_dt,
        MOV_DELTA.loc_sid_store
       FROM ldl_p_lew_core_ac.v_item_delivery_2 AS MOV_DELTA
        INNER JOIN ldl_p_lew_process_ac.v_wfm_last_export_2 AS DELTA_ITM_MOV ON DELTA_ITM_MOV.process_name =
           'export_wfm_store_delivery' AND DELTA_ITM_MOV.process_specification = 'delta' AND MOV_DELTA.dwh_updated >
          DELTA_ITM_MOV.last_export_tmsp
        INNER JOIN ldl_p_lew_process_ac.v_wfm_export_specification_2 AS EXPO_SPEC ON DELTA_ITM_MOV.export_specification =
          EXPO_SPEC.export_specification AND MOV_DELTA.client_id = EXPO_SPEC.client_id
       GROUP BY MOV_DELTA.client_id,
        MOV_DELTA.item_sid,
        MOV_DELTA.dwh_cal_dt,
        MOV_DELTA.loc_sid_store) AS delta ON MOV.client_id = delta.client_id AND MOV.loc_sid_store = delta.loc_sid_store
           AND MOV.dwh_cal_dt = delta.dwh_cal_dt AND MOV.item_sid = delta.item_sid
     UNION ALL
     SELECT MOV.client_id,
      MOV.item_sid,
      MOV.dwh_cal_dt AS dat_formdate,
      CAST(MOV.dir_del_id AS STRING) AS mov_dir_del_id,
      MOV.loc_sid_store AS st_loc_sid,
      MOV.loc_sid_wh AS wh_loc_sid,
      MOV.vat_id,
      MOV.order_area_cd,
      MOV.dayend_dt AS dat_dayend,
      3 -- deliverytype_id      in first select
,
      MOV.case_qty -- qty_case_del         in first select AS qty_case_dir_del  -- qty_case_del         in first select

      ,
      CAST(NULL AS NUMERIC),
      MOV.piece_qty
      -- qty_piece_del        in first select AS qty_piece_dir_del -- qty_piece_del        in first select
,
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC),
      0 AS from_fvm,
      MOV.dwh_load_id AS load_id
     FROM ldl_p_lew_core_ac.v_item_direct_delivery_2 AS MOV
      INNER JOIN (SELECT MOV_DELTA.client_id,
        MOV_DELTA.item_sid,
        MOV_DELTA.dwh_cal_dt,
        MOV_DELTA.loc_sid_store
       FROM ldl_p_lew_core_ac.v_item_direct_delivery_2 AS MOV_DELTA
        INNER JOIN ldl_p_lew_process_ac.v_wfm_last_export_2 AS DELTA_ITM_MOV ON DELTA_ITM_MOV.process_name =
           'export_wfm_store_delivery' AND DELTA_ITM_MOV.process_specification = 'delta' AND MOV_DELTA.dwh_updated >
          DELTA_ITM_MOV.last_export_tmsp
        INNER JOIN ldl_p_lew_process_ac.v_wfm_export_specification_2 AS EXPO_SPEC ON DELTA_ITM_MOV.export_specification =
          EXPO_SPEC.export_specification AND MOV_DELTA.client_id = EXPO_SPEC.client_id
       GROUP BY MOV_DELTA.client_id,
        MOV_DELTA.item_sid,
        MOV_DELTA.dwh_cal_dt,
        MOV_DELTA.loc_sid_store) AS delta ON MOV.client_id = delta.client_id AND MOV.loc_sid_store = delta.loc_sid_store
           AND MOV.dwh_cal_dt = delta.dwh_cal_dt AND MOV.item_sid = delta.item_sid
     UNION ALL
     SELECT MOV.client_id,
      MOV.item_sid,
      MOV.dwh_cal_dt AS dat_formdate,
      CAST(MOV.fv_del_id AS STRING) AS mov_fv_del_id,
      MOV.loc_sid_store AS st_loc_sid,
      MOV.loc_sid_wh AS wh_loc_sid,
      MOV.vat_id,
      MOV.order_area_cd,
      MOV.dayend_dt AS dat_dayend,
      4 -- deliverytype_id       in first select
,
      MOV.case_qty
      -- qty_case_del          in first select AS qty_case_fv_del   -- qty_case_del          in first select
,
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC),
      CAST(NULL AS NUMERIC),
      MOV.case_size_dec AS case_size_real,
      1 AS from_fvm,
      MOV.dwh_load_id AS load_id
     FROM ldl_p_lew_core_ac.v_item_fruits_vegetables_delivery_2 AS MOV
      INNER JOIN (SELECT MOV_DELTA.client_id,
        MOV_DELTA.item_sid,
        MOV_DELTA.dwh_cal_dt,
        MOV_DELTA.loc_sid_store
       FROM ldl_p_lew_core_ac.v_item_fruits_vegetables_delivery_2 AS MOV_DELTA
        INNER JOIN ldl_p_lew_process_ac.v_wfm_last_export_2 AS DELTA_ITM_MOV ON DELTA_ITM_MOV.process_name =
           'export_wfm_store_delivery' AND DELTA_ITM_MOV.process_specification = 'delta' AND MOV_DELTA.dwh_updated >
          DELTA_ITM_MOV.last_export_tmsp
        INNER JOIN ldl_p_lew_process_ac.v_wfm_export_specification_2 AS EXPO_SPEC ON DELTA_ITM_MOV.export_specification =
          EXPO_SPEC.export_specification AND MOV_DELTA.client_id = EXPO_SPEC.client_id
       GROUP BY MOV_DELTA.client_id,
        MOV_DELTA.item_sid,
        MOV_DELTA.dwh_cal_dt,
        MOV_DELTA.loc_sid_store) AS delta ON MOV.client_id = delta.client_id AND MOV.loc_sid_store = delta.loc_sid_store
           AND MOV.dwh_cal_dt = delta.dwh_cal_dt AND MOV.item_sid = delta.item_sid) AS inner_unions
   INNER JOIN ldl_p_lew_core_ac.v_location_2 AS LOC ON inner_unions.st_loc_sid = LOC.loc_sid AND inner_unions.client_id =
      LOC.client_id AND LOC.wh_store_mark = 'A'
   INNER JOIN ldl_p_lew_core_ac.v_item_2 AS ITEM0 ON inner_unions.item_sid = ITEM0.item_sid AND inner_unions.client_id =
     ITEM0.client_id
     /* ""src_case_size"" aus der v_item_2 Tabelle wird bei Initialanlage ohne bekannter case_size mit -1 befuellt und in DWH2.0 nachtraeglich nicht korrigiert.					
    Enthaelt der Datensatz in t_item_2 -1 fuer src_case_size, muss die case_size aus dieser Tabelle bezogen (Siehe CASE BEDINGUNG FUER case_size Spalte im Selekt). */
     
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_skey_act_2 AS SKEY_ACT ON inner_unions.client_id = SKEY_ACT.client_id AND
     inner_unions.item_sid = SKEY_ACT.item_sid
   INNER JOIN ldl_p_lew_core_ac.v_client_2 AS CLIENTS ON inner_unions.client_id = CLIENTS.client_id) AS row_result
GROUP BY client_id,
 country_lidl_cd,
 store,
 receiptdate,
 item_2;


/**** WARNING: MISSING DEPENDENT OBJECTS ""p_lew_core_ac.v_item_movement_record_2"", ""p_lew_core_ac.v_item_movement_record_pos_2"", ""p_lew_core_ac.v_location_2"", ""p_lew_core_ac.v_item_2"", ""p_lew_process_mstr_ac.v_wfm_export_config_2"", ""p_lew_core_ac.v_client_2"", ""p_lew_process_ac.v_wfm_export_core_delta_2"", ""p_lew_core_ac.v_store_form_2"", ""p_lew_process_ac.v_wfm_last_export_2"", ""p_lew_process_ac.v_wfm_export_specification_2"" ****/