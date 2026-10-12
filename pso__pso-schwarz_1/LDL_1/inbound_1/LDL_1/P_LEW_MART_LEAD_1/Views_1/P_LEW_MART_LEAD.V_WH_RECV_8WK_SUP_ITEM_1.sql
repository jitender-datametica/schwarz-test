/*
#----------------------------------------------------------------------------
# � LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD.v_wh_recv_8wk_sup_item_1
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | NAME              | DESCRIPTION OF CHANGES
# 1.0   06-12-2017   Michael Strauch     INITIAL VERSION
#                                        20171201_1515_TD_supplier_last8weeks_Rep1
# 1.1   09-11-2020   Torsten Bachmann    join to v_supplier_map_key_1 added
#                                        PatchNo: 2652, REP3-7579
# 1.2   04-03-2021   Torsten Bachmann    Rewritten because of SF synchronization and SF doesn't know PERIOD
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
# View
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_WH_RECV_8WK_SUP_ITEM_1 COMMENT = '$Revision: 16227 $'
/*
  apply a logic of a 8 week of delivered items:
    the requirement is, to show a supplier_1 when he delivered an item_1 within the last 8 weeks originating from each week

  e.g.
  x      - selected week in query or report
  |---|  - time range, which is check for a delivery

    10    11    12    13    14    15    16    17    18    19    20    21    22    23    24    25    26
                                                                       x
                     |--------------------------------------------------|
                                                                                               x
                                             |--------------------------------------------------|

  one entry means, the shown supplier_1 delivered the item_1 within the last 8 weeks originating from the shown week
*/
AS
SELECT recv.client_id
     , recv.loc_sid_wh AS wh_loc_sid
     , recv.src_wh_id  AS wh_id
     , recv.item_sid
     , recv.sup_sid                                   /*suppliers who delivered items within the last 8 weeks*/
     , cp.cy_week             AS recv_last8wk_cy_week /*week id of each period - 9 different weeks*/
     , Min(recv.dat_formdate) AS last_recv_dat        /*receiving date of the item_1*/
FROM (
        SELECT iws.client_id
              ,iws.loc_sid_wh
              ,iws.src_wh_id
              ,iws.item_sid
              ,supmap.sup_sid_map   AS sup_sid
              ,iws.dat_formdate
              ,iws.dat_formdate - cal.day_of_week                        AS wk_first_day      /*determine Monday as start date for the period*/
              ,cal2.cal_dt as intv
              ,cal.cy_week  AS recv_cy_week /*week id of the receiving date*/
        FROM P_LEW_MART_LEAD.v_mov_item_wh_supplier_rcv_1 AS iws
        INNER JOIN P_LEW_CORE_AC.v_supplier_map_key_1 AS supmap
           ON iws.client_id = supmap.client_id
          AND iws.sup_sid   = supmap.sup_sid
        INNER JOIN P_LEW_CORE_AC.v_cal_calendarday_1 AS cal
           ON iws.dat_formdate = cal.cal_dt
        INNER JOIN P_LEW_CORE_AC.v_cal_calendarday_1 AS cal2
           ON cal2.cal_dt between iws.dat_formdate - cal.day_of_week ANd iws.dat_formdate - cal.day_of_week + 63
          AND cal2.day_of_week = 1   /* only Mondays */
        ) AS recv
INNER JOIN P_LEW_CORE_AC.v_cal_calendarday_1 AS cp
   ON recv.intv = cp.cal_dt
GROUP BY recv.client_id
       , recv.loc_sid_wh
       , recv.src_wh_id
       , recv.item_sid
       , recv.sup_sid
       , cp.cy_week
;
