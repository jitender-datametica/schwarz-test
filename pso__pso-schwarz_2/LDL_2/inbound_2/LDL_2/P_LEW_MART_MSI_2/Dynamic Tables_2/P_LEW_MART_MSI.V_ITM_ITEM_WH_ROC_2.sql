
/*
#-------------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.v_itm_item_wh_roc_2
#-------------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  29.10.2018    Arnold,Arne              V_LOC_MAP_KEY_2 mit V_WAREHOUSE_2 ersetzt
#  1.4  30.09.2020    Martin Lysik             20200928_2600_WH_MOVE_ROC_Access
#                                              Pointed to new ROC table
#  1.5  17.03.2021    Torsten Bachmann         Transall shutdown, repointing v_wawi_cal -> v_cal
#                                              PatchNo: 2790, REP3-8380
#-------------------------------------------------------------------------------
*/

/*
#-------------------------------------------------------------------------------
# View: P_LEW_MART_MSI.V_ITM_ITEM_WH_ROC_2
#-------------------------------------------------------------------------------
*/
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_ITEM_WH_ROC_2 COMMENT = '$Revision: 16817 $'

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT
  i.client_id
, wh.src_wh_id   AS wh_id
, i.item_sid     AS item_id
, c.cal_dt       AS dat_valid
, CASE WHEN i.stock_slot_fg             = 1 THEN '!' ELSE '' END AS stock_slot_fg
, CASE WHEN i.stock_case_size_fg        = 1 THEN '*' ELSE '' END AS stock_case_size_fg
, CASE WHEN i.qty_piece_five_weeks_fg   = 1 THEN '+' ELSE '' END AS qty_piece_five_weeks_fg
, CASE WHEN i.qty_piece_vs_case_size_fg = 1 THEN '~' ELSE '' END AS qty_piece_vs_case_size_fg
, CASE WHEN i.stock_slot_fg = 1 THEN '!' ELSE '' END
   || CASE WHEN i.stock_case_size_fg = 1 THEN '*' ELSE '' END
   || CASE WHEN i.qty_piece_five_weeks_fg = 1 THEN '+' ELSE '' END
   || CASE WHEN i.qty_piece_vs_case_size_fg = 1 THEN '~' ELSE '' END
  AS flags_combined
/* Vorjahreswerte fuer Monatsauswertung */
, CASE WHEN r_vj.stock_slot_fg = 1 THEN '!' 
       WHEN r_vj.stock_slot_fg = 0 THEN '' END AS stock_slot_fg_vj
, CASE WHEN r_vj.stock_case_size_fg = 1 THEN '*'
       WHEN r_vj.stock_case_size_fg = 0 THEN '' END AS stock_case_size_fg_vj
, CASE WHEN r_vj.qty_piece_five_weeks_fg = 1 THEN '+'
       WHEN r_vj.qty_piece_five_weeks_fg = 0 THEN '' END AS qty_piece_five_weeks_fg_vj
, CASE WHEN r_vj.qty_piece_vs_case_size_fg = 1 THEN '~'
       WHEN r_vj.qty_piece_vs_case_size_fg = 0 THEN '' END AS qty_piece_vs_case_size_fg_vj
, stock_slot_fg_vj || stock_case_size_fg_vj || qty_piece_five_weeks_fg_vj || qty_piece_vs_case_size_fg_vj AS flags_combined_vj
/* Vorjahreswerte fuer Wochenauswertung */
,CASE WHEN r_vj_sw.stock_slot_fg = 1 THEN '!'
      WHEN r_vj_sw.stock_slot_fg = 0 THEN '' END AS stock_slot_fg_vj_sw
,CASE WHEN r_vj_sw.stock_case_size_fg = 1 THEN '*'
      WHEN r_vj_sw.stock_case_size_fg = 0 THEN '' END AS stock_case_size_fg_vj_sw
,CASE WHEN r_vj_sw.qty_piece_five_weeks_fg = 1 THEN '+'
      WHEN r_vj_sw.qty_piece_five_weeks_fg = 0 THEN '' END AS qty_piece_five_weeks_fg_vj_sw
,CASE WHEN r_vj_sw.qty_piece_vs_case_size_fg = 1 THEN '~'
      WHEN r_vj_sw.qty_piece_vs_case_size_fg = 0 THEN '' END AS qty_pce_vs_case_size_fg_vj_sw
, stock_slot_fg_vj_sw || stock_case_size_fg_vj_sw || qty_piece_five_weeks_fg_vj_sw || qty_pce_vs_case_size_fg_vj_sw AS flags_combined_vj_sw
FROM P_LEW_BIL_AC.v_item_wh_roc_2 AS i
/* Aufloesung WH */
INNER JOIN P_LEW_BIL_AC.v_warehouse_2 AS wh
ON  wh.client_id  = i.client_id
AND wh.loc_sid_wh = i.loc_sid
AND wh.dwh_actual_fg = 1
INNER JOIN P_LEW_CORE_AC.v_cal_calendarday_2 AS c
ON  c.cal_dt BETWEEN i.dwh_valid_from AND  i.dwh_valid_to
AND c.cal_dt      <= CURRENT_DATE
AND c.busyear_seq >= -1
INNER JOIN P_LEW_CORE_AC.v_cal_week_2 AS c_week_vj
ON  c.cy_week = c_week_vj.cy_week
INNER JOIN P_LEW_CORE_AC.v_cal_calendarday_2 AS c_vj_sw
ON  c_week_vj.cy_week_prev_1y = c_vj_sw.cy_week
AND c_vj_sw.day_of_week       = c.day_of_week
LEFT OUTER JOIN P_LEW_BIL_AC.v_item_wh_roc_2 AS r_vj_sw
ON  i.client_id = r_vj_sw.client_id
AND i.item_sid  = r_vj_sw.item_sid
AND i.loc_sid   = r_vj_sw.loc_sid
AND c_vj_sw.cal_dt BETWEEN r_vj_sw.dwh_valid_from AND  r_vj_sw.dwh_valid_to
LEFT OUTER JOIN P_LEW_BIL_AC.v_item_wh_roc_2 AS r_vj
ON  i.client_id = r_vj.client_id
AND i.item_sid  = r_vj.item_sid
AND i.loc_sid   = r_vj.loc_sid
AND ADD_MONTHS(c.cal_dt, -12) BETWEEN r_vj.dwh_valid_from AND  r_vj.dwh_valid_to
;
