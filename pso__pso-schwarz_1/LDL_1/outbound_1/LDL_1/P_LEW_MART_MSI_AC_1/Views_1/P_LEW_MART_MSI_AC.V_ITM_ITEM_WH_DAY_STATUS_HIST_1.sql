/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI_AC.V_ITM_ITEM_WH_DAY_STATUS_HIST_1
#----------------------------------------------------------------------------
# History:
#  1.0  17.07.2024    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_itm_item_wh_day_status_hist_1 (client_id, wh_id, loc_sid_wh, item_sid,
status_hist_id, item_status_reason, dwh_cal_dt) AS SELECT *
FROM ldl_p_lew_mart_msi.v_itm_item_wh_day_status_hist_1;