/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_ITM_ITEM_WH_DAY_STATUS_HIST_1
#----------------------------------------------------------------------------
# History:
#  1.0  17.07.2024    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_itm_item_wh_day_status_hist_1 (client_id, wh_id, loc_sid_wh, item_sid,
status_hist_id, item_status_reason, dwh_cal_dt) AS /* Warehouse - ASIS */ SELECT ITM.client_id,
 WH.src_wh_id AS wh_id,
 STS.wh_loc_sid AS loc_sid_wh,
 ITM.item_sid,
 STS.item_status AS status_hist_id,
 STS.item_status_reason,
 CAL.cal_dt AS dwh_cal_dt
FROM ldl_p_lew_core_ac.v_item_1 AS ITM
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_wh_1 AS STS ON ITM.client_id = STS.client_id AND ITM.item_sid = STS.item_sid
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL ON CAL.cal_dt BETWEEN STS.dat_rec_start AND STS.dat_rec_end
  /* status_1 id ASWAS */
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON STS.client_id = WH.client_id AND STS.wh_loc_sid = WH.loc_sid_wh AND WH
     .dwh_actual_fg = 1 AND WH.deleted_fg = 0 AND WH.bges_active_fg = 1;