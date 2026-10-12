/*
#----------------------------------------------------------------------------
# � LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD.v_wh_recv_8wk_sup_item_2
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | NAME              | DESCRIPTION OF CHANGES
# 1.0   06-12-2017   Michael Strauch     INITIAL VERSION
#                                        20171201_1515_TD_supplier_last8weeks_Rep1
# 1.1   09-11-2020   Torsten Bachmann    CROSS JOIN to v_supplier_map_key_2 added
#                                        PatchNo: 2652, REP3-7579
# 1.2   04-03-2021   Torsten Bachmann    Rewritten because of SF synchronization and SF doesn't know PERIOD
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
# View
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_wh_recv_8wk_sup_item_2 OPTIONS(DESCRIPTION = `$Revision: 16227 $`) AS
SELECT recv.client_id,
 recv.loc_sid_wh AS wh_loc_sid,
 recv.src_wh_id AS wh_id,
 recv.item_sid,
 recv.sup_sid,
 CP.cy_week AS recv_last8wk_cy_week,
 MIN(recv.dat_formdate) AS last_recv_dat
FROM (SELECT IWS.client_id,
   IWS.loc_sid_wh,
   IWS.src_wh_id,
   IWS.item_sid,
   SUPMAP.sup_sid_map AS sup_sid,
   IWS.dat_formdate,
   DATE_SUB(IWS.dat_formdate, INTERVAL CAST(ROUND(CAL.day_of_week) AS INTEGER) DAY) AS wk_first_day,
   CAL2.cal_dt AS intv,
   CAL.cy_week AS recv_cy_week
  FROM ldl_p_lew_mart_lead.v_mov_item_wh_supplier_rcv_2 AS IWS
   INNER JOIN ldl_p_lew_core_ac.v_supplier_map_key_2 AS SUPMAP ON IWS.client_id = SUPMAP.client_id AND IWS.sup_sid =
     SUPMAP.sup_sid
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL ON IWS.dat_formdate = CAL.cal_dt
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL2 ON CAL2.cal_dt BETWEEN DATE_SUB(IWS.dat_formdate, INTERVAL CAST(ROUND(CAL.day_of_week) AS INTEGER)
      DAY) AND (DATE_ADD(DATE_SUB(IWS.dat_formdate, INTERVAL CAST(ROUND(CAL.day_of_week) AS INTEGER) DAY),
       INTERVAL 63 DAY)) AND CAL2.day_of_week = 1) AS recv
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CP ON recv.intv = CP.cal_dt
GROUP BY recv.client_id,
 wh_loc_sid,
 wh_id,
 recv.item_sid,
 recv.sup_sid,
 recv_last8wk_cy_week;