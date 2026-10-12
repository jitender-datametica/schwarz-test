/*
#-------------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.v_itm_item_wh_roc_1
#-------------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  29.10.2018    Arnold,Arne              V_LOC_MAP_KEY_1 mit V_WAREHOUSE_1 ersetzt
#  1.4  30.09.2020    Martin Lysik             20200928_2600_WH_MOVE_ROC_Access
#                                              Pointed to new ROC table
#  1.5  17.03.2021    Torsten Bachmann         Transall shutdown, repointing v_wawi_cal -> v_cal
#                                              PatchNo: 2790, REP3-8380
#-------------------------------------------------------------------------------
*/

/*
#-------------------------------------------------------------------------------
# View: P_LEW_MART_MSI.V_ITM_ITEM_WH_ROC_1
#-------------------------------------------------------------------------------
*/


CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_itm_item_wh_roc_1
AS
/* Vorjahreswerte fuer Monatsauswertung */ /* Vorjahreswerte fuer Wochenauswertung */ /* Aufloesung WH */ SELECT I.client_id
 ,
 WH.src_wh_id AS wh_id,
 I.item_sid AS item_id,
 C.cal_dt AS dat_valid,
  CASE
  WHEN I.stock_slot_fg = 1
  THEN '!'
  ELSE ''
  END AS stock_slot_fg,
  CASE
  WHEN I.stock_case_size_fg = 1
  THEN '*'
  ELSE ''
  END AS stock_case_size_fg,
  CASE
  WHEN I.qty_piece_five_weeks_fg = 1
  THEN '+'
  ELSE ''
  END AS qty_piece_five_weeks_fg,
  CASE
  WHEN I.qty_piece_vs_case_size_fg = 1
  THEN '~'
  ELSE ''
  END AS qty_piece_vs_case_size_fg,
     CASE
     WHEN I.stock_slot_fg = 1
     THEN '!'
     ELSE ''
     END || CASE
     WHEN I.stock_case_size_fg = 1
     THEN '*'
     ELSE ''
     END || CASE
    WHEN I.qty_piece_five_weeks_fg = 1
    THEN '+'
    ELSE ''
    END || CASE
   WHEN I.qty_piece_vs_case_size_fg = 1
   THEN '~'
   ELSE ''
   END AS flags_combined,
  CASE
  WHEN R_VJ.stock_slot_fg = 1
  THEN '!'
  WHEN R_VJ.stock_slot_fg = 0
  THEN ''
  ELSE NULL
  END AS stock_slot_fg_vj,
  CASE
  WHEN R_VJ.stock_case_size_fg = 1
  THEN '*'
  WHEN R_VJ.stock_case_size_fg = 0
  THEN ''
  ELSE NULL
  END AS stock_case_size_fg_vj,
  CASE
  WHEN R_VJ.qty_piece_five_weeks_fg = 1
  THEN '+'
  WHEN R_VJ.qty_piece_five_weeks_fg = 0
  THEN ''
  ELSE NULL
  END AS qty_piece_five_weeks_fg_vj,
  CASE
  WHEN R_VJ.qty_piece_vs_case_size_fg = 1
  THEN '~'
  WHEN R_VJ.qty_piece_vs_case_size_fg = 0
  THEN ''
  ELSE NULL
  END AS qty_piece_vs_case_size_fg_vj,
     CASE
     WHEN R_VJ.stock_slot_fg = 1
     THEN '!'
     WHEN R_VJ.stock_slot_fg = 0
     THEN ''
     ELSE NULL
     END || CASE
     WHEN R_VJ.stock_case_size_fg = 1
     THEN '*'
     WHEN R_VJ.stock_case_size_fg = 0
     THEN ''
     ELSE NULL
     END || CASE
    WHEN R_VJ.qty_piece_five_weeks_fg = 1
    THEN '+'
    WHEN R_VJ.qty_piece_five_weeks_fg = 0
    THEN ''
    ELSE NULL
    END || CASE
   WHEN R_VJ.qty_piece_vs_case_size_fg = 1
   THEN '~'
   WHEN R_VJ.qty_piece_vs_case_size_fg = 0
   THEN ''
   ELSE NULL
   END AS flags_combined_vj,
  CASE
  WHEN R_VJ_SW.stock_slot_fg = 1
  THEN '!'
  WHEN R_VJ_SW.stock_slot_fg = 0
  THEN ''
  ELSE NULL
  END AS stock_slot_fg_vj_sw,
  CASE
  WHEN R_VJ_SW.stock_case_size_fg = 1
  THEN '*'
  WHEN R_VJ_SW.stock_case_size_fg = 0
  THEN ''
  ELSE NULL
  END AS stock_case_size_fg_vj_sw,
  CASE
  WHEN R_VJ_SW.qty_piece_five_weeks_fg = 1
  THEN '+'
  WHEN R_VJ_SW.qty_piece_five_weeks_fg = 0
  THEN ''
  ELSE NULL
  END AS qty_piece_five_weeks_fg_vj_sw,
  CASE
  WHEN R_VJ_SW.qty_piece_vs_case_size_fg = 1
  THEN '~'
  WHEN R_VJ_SW.qty_piece_vs_case_size_fg = 0
  THEN ''
  ELSE NULL
  END AS qty_pce_vs_case_size_fg_vj_sw,
     CASE
     WHEN R_VJ_SW.stock_slot_fg = 1
     THEN '!'
     WHEN R_VJ_SW.stock_slot_fg = 0
     THEN ''
     ELSE NULL
     END || CASE
     WHEN R_VJ_SW.stock_case_size_fg = 1
     THEN '*'
     WHEN R_VJ_SW.stock_case_size_fg = 0
     THEN ''
     ELSE NULL
     END || CASE
    WHEN R_VJ_SW.qty_piece_five_weeks_fg = 1
    THEN '+'
    WHEN R_VJ_SW.qty_piece_five_weeks_fg = 0
    THEN ''
    ELSE NULL
    END || CASE
   WHEN R_VJ_SW.qty_piece_vs_case_size_fg = 1
   THEN '~'
   WHEN R_VJ_SW.qty_piece_vs_case_size_fg = 0
   THEN ''
   ELSE NULL
   END AS flags_combined_vj_sw
FROM ldl_p_lew_bil_ac.v_item_wh_roc_1 AS I
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON I.client_id = WH.client_id AND I.loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS C ON C.cal_dt BETWEEN I.dwh_valid_from AND I.dwh_valid_to AND C.cal_dt
     <= CURRENT_DATE AND C.busyear_seq >= - 1
 INNER JOIN ldl_p_lew_core_ac.v_cal_week_1 AS C_WEEK_VJ ON C.cy_week = C_WEEK_VJ.cy_week
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS C_VJ_SW ON C_WEEK_VJ.cy_week_prev_1y = C_VJ_SW.cy_week AND C.day_of_week
    = C_VJ_SW.day_of_week
 LEFT JOIN ldl_p_lew_bil_ac.v_item_wh_roc_1 AS R_VJ_SW ON I.client_id = R_VJ_SW.client_id AND I.item_sid = R_VJ_SW.item_sid
      AND I.loc_sid = R_VJ_SW.loc_sid AND C_VJ_SW.cal_dt BETWEEN R_VJ_SW.dwh_valid_from AND R_VJ_SW.dwh_valid_to
 LEFT JOIN ldl_p_lew_bil_ac.v_item_wh_roc_1 AS R_VJ ON I.client_id = R_VJ.client_id AND I.item_sid = R_VJ.item_sid AND I.loc_sid
     = R_VJ.loc_sid AND IF(C.cal_dt = LAST_DAY(C.cal_dt), LAST_DAY(DATE_ADD(C.cal_dt, INTERVAL - 12 MONTH)), DATE_ADD(C
     .cal_dt, INTERVAL - 12 MONTH)) BETWEEN R_VJ.dwh_valid_from AND R_VJ.dwh_valid_to;

