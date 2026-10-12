/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- -----------------------------------
#  1.0 2024-01-04 Marcin Kikola           AP0150474 Article Hierarchy_1 Initial version
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_agg_rcpt_hdr_store_report_ldpl_wk_1 (currency_iso_cd
OPTIONS(description='ISO code for the currency of the client'), curr_tot_id
OPTIONS(description='Fixe Werte fur EUR=0 GBP=40 sonst Client_Id'), client_id
OPTIONS(description='Identifier for client'), wh_id OPTIONS(description='Warehouse ID'), move_to_store_id
OPTIONS(description='Filialnummer nach letztem Filialumzug'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), cy_week
OPTIONS(description='Week number'), cy_week_prev_1w OPTIONS(description='Next Week number'), store_tot_net_val
OPTIONS(description='Total net value : Current week'), store_lp_net_val
OPTIONS(description='LidlPlus net value : Current week'), store_non_lp_net_val
OPTIONS(description='Non-LidlPlus net value : Current week'), wh_tot_net_val
OPTIONS(description='Total net value at wh_id level : Current week'), wh_lp_net_val
OPTIONS(description='LidlPlus net value at wh_id level: Current week'), client_tot_net_val
OPTIONS(description='Total net value at client_id level : Current week'), client_lp_net_val
OPTIONS(description='LidlPlus net value at client_id level: Current week'), store_tot_rcpt
OPTIONS(description='Number of LidlPlus receipts : Current week'), store_lp_rcpt
OPTIONS(description='Number of total receipts : Current week'), store_non_lp_rcpt
OPTIONS(description='Number of non-LidlPlus receipts : Current week'), wh_tot_rcpt
OPTIONS(description='Number of LidlPlus receipts at wh_id level: Current week'), wh_lp_rcpt
OPTIONS(description='Number of total receipts at wh_id level: Current week'), client_tot_rcpt
OPTIONS(description='Number of LidlPlus receipts at client_id level: Current week'), client_lp_rcpt
OPTIONS(description='Number of total receipts at client_id level: Current week'), count_customer_sid
OPTIONS(description='distinct coutn of customer sid'))
OPTIONS(DESCRIPTION = `LIDLPLUS : VIEW WITH AGGREGATIONS AT WH_ID AND CLIENT_ID USED FOR STORE REPORT IN FE`) AS WITH
 CTE_CAL AS (SELECT CAL.cal_dt,
   CAL.cy_week,
   CAL.cy_week_seq,
   WW_NEXT_1W.cy_week AS cy_week_prev_1w
  FROM ldl_p_lew_core.t_cal_calendarday_1 AS CAL
   LEFT JOIN ldl_p_lew_core.t_cal_week_1 AS WW_NEXT_1W ON CAL.cy_week = WW_NEXT_1W.cy_week_prev_1w), A1 AS (SELECT A.currency_iso_cd
   ,
   A.curr_tot_id,
   A.client_id,
   S.wh_id,
   A.move_to_store_id,
   A.aspect_id,
   cal.cy_week,
   cal.cy_week_prev_1w,
   COUNT(DISTINCT CASE
     WHEN A.lidlplus_cust_fg = 'Y'
     THEN A.customer_sid
     ELSE NULL
     END) AS count_customer_sid,
   SUM(A.total_net_val) AS store_tot_net_val,
   SUM(CASE
     WHEN A.lidlplus_cust_fg = 'Y'
     THEN A.total_net_val
     ELSE 0
     END) AS store_lp_net_val,
   SUM(CASE
     WHEN A.lidlplus_cust_fg = 'N'
     THEN A.total_net_val
     ELSE 0
     END) AS store_non_lp_net_val,
   SUM(A.number_of_receipts) AS store_tot_rcpt,
   SUM(CASE
     WHEN A.lidlplus_cust_fg = 'Y'
     THEN A.number_of_receipts
     ELSE 0
     END) AS store_lp_rcpt,
   SUM(CASE
     WHEN A.lidlplus_cust_fg = 'N'
     THEN A.number_of_receipts
     ELSE 0
     END) AS store_non_lp_rcpt
  FROM ldl_p_lew_mart_lidl_digital.t_agg_rcpt_hdr_ldpl_day_1 AS A
   INNER JOIN ldl_p_lew_mart_lidl_digital.v_org_store_merge_1 AS S ON A.client_id = S.client_id AND A.move_to_store_id = S
      .move_to_store_id AND A.aspect_id = S.aspect_id
   INNER JOIN CTE_CAL AS cal ON A.dwh_cal_dt = cal.cal_dt
  WHERE S.move_fg = 0
   AND S.orig_store_nr <> S.wh_id
   AND cal.cy_week_seq BETWEEN - 6 AND (- 1)
  GROUP BY A.currency_iso_cd,
   A.curr_tot_id,
   A.client_id,
   S.wh_id,
   A.move_to_store_id,
   A.aspect_id,
   cal.cy_week,
   cal.cy_week_prev_1w) (SELECT currency_iso_cd,
   curr_tot_id,
   client_id,
   wh_id,
   move_to_store_id,
   aspect_id,
   cy_week,
   cy_week_prev_1w,
   store_tot_net_val,
   store_lp_net_val,
   store_non_lp_net_val,
   SUM(store_tot_net_val) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(curr_tot_id AS STRING), CAST(cy_week AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS wh_tot_net_val,
   SUM(store_lp_net_val) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(curr_tot_id AS STRING), CAST(cy_week AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS wh_lp_net_val,
   SUM(store_tot_net_val) OVER (PARTITION BY CAST(client_id AS STRING), CAST(curr_tot_id AS STRING), CAST(cy_week AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS client_tot_net_val,
   SUM(store_lp_net_val) OVER (PARTITION BY CAST(client_id AS STRING), CAST(curr_tot_id AS STRING), CAST(cy_week AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS client_lp_net_val,
   store_tot_rcpt,
   store_lp_rcpt,
   store_non_lp_rcpt,
   SUM(store_tot_rcpt) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(curr_tot_id AS STRING), CAST(cy_week AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS wh_tot_rcpt,
   SUM(store_lp_rcpt) OVER (PARTITION BY CAST(client_id AS STRING), wh_id, CAST(curr_tot_id AS STRING), CAST(cy_week AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS wh_lp_rcpt,
   SUM(store_tot_rcpt) OVER (PARTITION BY CAST(client_id AS STRING), CAST(curr_tot_id AS STRING), CAST(cy_week AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS client_tot_rcpt,
   SUM(store_lp_rcpt) OVER (PARTITION BY CAST(client_id AS STRING), CAST(curr_tot_id AS STRING), CAST(cy_week AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS client_lp_rcpt,
   count_customer_sid
  FROM A1);