/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.v_bw_ejr_turnover_writeoff_pv_values
#----------------------------------------------------------------------------
# History:
#   1.0            05.10.2022        Ulrich Ross              Init
#                                                             User Story 391252
#                                                             SAP BW Performance Issue - SF
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_ejr_turnover_writeoff_pv_values (client_id, dwh_cal_dt, item_id,
currency_iso_cd, m1401, m1102pvs, m1201bnl) AS SELECT client_id,
 dwh_cal_dt,
 item_id,
 currency_iso_cd,
 m1401,
 m1102pvs,
 m1201bnl
FROM ldl_p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_values;