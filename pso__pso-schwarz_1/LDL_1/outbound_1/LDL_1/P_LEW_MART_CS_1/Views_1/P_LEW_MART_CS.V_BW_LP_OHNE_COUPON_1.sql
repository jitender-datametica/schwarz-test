/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_LP_OHNE_COUPON_1
#----------------------------------------------------------------------------
# History:
#  1.0  30.08.2023    Ulrich Ross               Init
#                                               User Story 501418
#  1.1  02.10.2023    Ulrich Ross               Add DIV0
#                                               User Story 532588
#                                             
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_lp_ohne_coupon_1 AS WITH LP_CUST AS (SELECT CAL.cy_month,
   R_CL.client_id,
    CASE
    WHEN COUNT(DISTINCT LP_RCPT.customer_sid) = 0
    THEN NULL
    ELSE COUNT(DISTINCT LP_RCPT.customer_sid)
    END AS new_cust,
   COUNT(DISTINCT LP_RCPT.customer_sid) AS new_cust_per_country,
   COUNT(DISTINCT LP_RCPT.customer_sid) AS reg_cust
  FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_rcpt_hdr_ldpl_day_1 AS LP_RCPT
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday_1 AS CAL ON LP_RCPT.dwh_cal_dt = CAL.dat_calendar
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead_1 AS R_CL ON LP_RCPT.client_id = R_CL.client_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_currency_1 AS CURR ON LP_RCPT.client_id = CURR.client_id AND LP_RCPT.curr_tot_id
       = CURR.curr_tot_id AND CURR.curr_tot_id = 0
  WHERE LP_RCPT.lidlplus_cust_fg = 'Y'
   AND LP_RCPT.aspect_id = 2
   AND CAL.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_1
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_1
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
   AND R_CL.dashboard_relevant_fg = 1
  GROUP BY CAL.cy_month,
   R_CL.client_id), LP_RECP AS (SELECT CAL0.cy_month,
   R_CL0.client_id,
   SUM(CASE
     WHEN CLIENT_RCPT.lidlplus_cust_fg = 'Y'
     THEN CLIENT_RCPT.number_of_receipts
     ELSE NULL
     END) AS lp_cust_recp,
   SUM(CLIENT_RCPT.number_of_receipts) AS all_num_recp,
   SUM(CLIENT_RCPT.total_net_val) AS all_total_net_val,
   SUM(CASE
     WHEN CLIENT_RCPT.lidlplus_cust_fg = 'Y'
     THEN CLIENT_RCPT.total_net_val
     ELSE NULL
     END) AS lp_total_net_val,
   SUM(CASE
     WHEN CLIENT_RCPT.lidlplus_cust_fg = 'Y'
     THEN CLIENT_RCPT.number_of_receipts
     ELSE NULL
     END) AS lp_num_recp,
   SUM(CASE
     WHEN CLIENT_RCPT.lidlplus_cust_fg = 'N'
     THEN CLIENT_RCPT.total_net_val
     ELSE NULL
     END) AS non_lp_total_net_val,
   SUM(CASE
     WHEN CLIENT_RCPT.lidlplus_cust_fg = 'N'
     THEN CLIENT_RCPT.number_of_receipts
     ELSE NULL
     END) AS non_lp_num_recp
  FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_client_rcpt_hdr_ldpl_day_1 AS CLIENT_RCPT
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday_1 AS CAL0 ON CLIENT_RCPT.dwh_cal_dt = CAL0.dat_calendar
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead_1 AS R_CL0 ON CLIENT_RCPT.client_id = R_CL0.client_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_currency_1 AS CURR0 ON CLIENT_RCPT.client_id = CURR0.client_id AND CLIENT_RCPT.curr_tot_id
       = CURR0.curr_tot_id AND CURR0.curr_tot_id = 0
  WHERE CLIENT_RCPT.aspect_id = 2
   AND CAL0.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_1
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_1
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
   AND R_CL0.dashboard_relevant_fg = 1
  GROUP BY CAL0.cy_month,
   R_CL0.client_id), LP_CUST_ALL AS (SELECT COALESCE(lp_cust.cy_month, lp_recp.cy_month) AS cy_month,
   COALESCE(lp_cust.client_id, lp_recp.client_id) AS client_id,
   lp_cust.new_cust,
   lp_cust.new_cust_per_country,
   lp_recp.lp_cust_recp,
   lp_cust.reg_cust
  FROM LP_CUST AS lp_cust
   FULL JOIN LP_RECP AS lp_recp ON lp_cust.client_id = lp_recp.client_id AND lp_cust.cy_month = lp_recp.cy_month),
 LP_RECP_DISC AS (SELECT CAL1.cy_month,
   R_CL1.client_id,
   SUM(CASE
     WHEN LP_RCPT0.lidlplus_cust_fg = 'Y'
     THEN LP_RCPT0.discount_val
     ELSE NULL
     END) AS lp_cust_discval,
   SUM(CASE
     WHEN LP_RCPT0.lidlplus_cust_fg = 'N'
     THEN LP_RCPT0.discount_val
     ELSE NULL
     END) AS non_lp_cust_discval,
   SUM(LP_RCPT0.discount_val) AS discval_all
  FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_rcpt_hdr_ldpl_day_1 AS LP_RCPT0
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday_1 AS CAL1 ON LP_RCPT0.dwh_cal_dt = CAL1.dat_calendar
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead_1 AS R_CL1 ON LP_RCPT0.client_id = R_CL1.client_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_currency_1 AS CURR1 ON LP_RCPT0.client_id = CURR1.client_id AND LP_RCPT0.curr_tot_id
       = CURR1.curr_tot_id AND CURR1.curr_tot_id = 0
  WHERE LP_RCPT0.aspect_id = 2
   AND CAL1.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_1
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_1
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
   AND R_CL1.dashboard_relevant_fg = 1
  GROUP BY CAL1.cy_month,
   R_CL1.client_id), LP_CUST_REG_DEREG AS (SELECT LP_CRD.cy_month,
   R_CL3.client_id,
   SUM(LP_CRD.cm_dereg_cnt) AS cm_dereg_cnt,
   SUM(LP_CRD.cm_reg_cnt) AS cm_reg_cnt,
   SUM(LP_CRD.cm_total_new_reg_cnt) AS cm_total_new_reg_cnt
  FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_cust_reg_dereg_ldpl_mth_1 AS LP_CRD
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead_1 AS R_CL3 ON LP_CRD.client_id = R_CL3.client_id
  WHERE LP_CRD.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_1
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_1
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
   AND R_CL3.dashboard_relevant_fg = 1
  GROUP BY LP_CRD.cy_month,
   R_CL3.client_id), LD_DWNLOAD AS (SELECT CAL3.cy_month,
   R_CL4.client_id,
   SUM(LP_APP_STORE.download_cnt) AS download_cnt
  FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_app_store_ldpl_day_1 AS LP_APP_STORE
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday_1 AS CAL3 ON LP_APP_STORE.dwh_cal_dt = CAL3.dat_calendar
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead_1 AS R_CL4 ON LP_APP_STORE.client_id = R_CL4.client_id
  WHERE R_CL4.client_id IN (SELECT R_REGION.client_id
     FROM ldl_p_lew_mart_msi_ac.v_ref_aspect_1 AS R_ASP
      INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_gl_region_merge_1 AS R_REGION ON R_ASP.aspect_id = R_REGION.aspect_id
     WHERE R_ASP.aspect_id = 2
     GROUP BY R_REGION.client_id)
   AND R_CL4.dashboard_relevant_fg = 1
   AND CAL3.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_1
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_1
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
  GROUP BY CAL3.cy_month,
   R_CL4.client_id), STORE_PER_CLIENT AS (SELECT SOM.cy_month,
   R_CL5.client_id,
   COUNT(DISTINCT CAST(SOM.client_id AS STRING) || '_' || CAST(SOM.move_to_store_id AS STRING)) AS store_cnt
  FROM ldl_p_lew_mart_lidl_digital_ac.v_store_open_month_1 AS SOM
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead_1 AS R_CL5 ON SOM.client_id = R_CL5.client_id
  WHERE SOM.cm_mth_ending_str_open_fg = 1
   AND SOM.aspect_id = 2 -- AND r_cl.client_id IN (4)

   AND R_CL5.dashboard_relevant_fg = 1
   AND SOM.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_1
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_1
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
  GROUP BY SOM.cy_month,
   R_CL5.client_id) (-- AND r_cl.client_id IN (4)
 SELECT R_CL6.client_id,
   R_CL6.country_iso_cd,
   R_CL6.country_desc AS client_desc,
   CMD.cy_month,
   CMD.cy_month_name,
   CMD.byr AS year,
   MAX(lp_cust_all.new_cust) AS new_cust,
   MAX(lp_recp_disc.lp_cust_discval) AS lp_cust_discval,
   MAX(lp_recp_disc.non_lp_cust_discval) AS non_lp_cust_discval,
   MAX(lp_recp_disc.discval_all) AS discval_all,
   MAX(lp_recp.all_num_recp) AS all_num_recp,
   MAX(lp_cust_reg_dereg.cm_dereg_cnt) AS cm_dereg_cnt,
   MAX(lp_cust_all.new_cust_per_country) AS new_cust_per_country,
   MAX(lp_recp.lp_total_net_val) AS lp_total_net_val,
   MAX(ld_dwnload.download_cnt) AS download_cnt,
   MAX(lp_recp.non_lp_total_net_val) AS non_lp_total_net_val,
   MAX(store_per_client.store_cnt) AS store_cnt,
   MAX(lp_cust_reg_dereg.cm_reg_cnt) AS cm_reg_cnt,
   MAX(lp_recp.non_lp_num_recp) AS non_lp_num_recp,
   MAX(lp_cust_all.lp_cust_recp) AS lp_cust_recp,
   MAX(lp_cust_reg_dereg.cm_total_new_reg_cnt) AS cm_total_new_reg_cnt,
   MAX(lp_cust_all.reg_cust) AS reg_cust,
   MAX(lp_recp.all_total_net_val) AS all_total_net_val,
   MAX(lp_recp.lp_num_recp) AS lp_num_recp,
   ROUND(IF(MAX(lp_recp.all_total_net_val) = 0, 0, SAFE_DIVIDE(MAX(lp_recp_disc.lp_cust_discval), MAX(lp_recp.all_total_net_val
        ))) * 100, 3) AS lp_pricechange_disc_perc,
   ROUND(IF(MAX(lp_recp.all_total_net_val) = 0, 0, SAFE_DIVIDE(MAX(lp_recp_disc.non_lp_cust_discval), MAX(lp_recp.all_total_net_val
        ))) * 100, 3) AS non_lp_pricechange_disc_perc,
   ROUND(IF(MAX(lp_recp.all_total_net_val) = 0, 0, SAFE_DIVIDE(MAX(lp_recp_disc.discval_all), MAX(lp_recp.all_total_net_val
        ))) * 100, 3) AS all_pricechange_disc_perc,
   ROUND(IF(MAX(lp_recp.lp_total_net_val) = 0, 0, SAFE_DIVIDE(MAX(lp_recp_disc.lp_cust_discval), MAX(lp_recp.lp_total_net_val
        ))) * 100, 3) AS lp_pricechange_ejr_perc,
   ROUND(IF(MAX(lp_cust_reg_dereg.cm_total_new_reg_cnt) = 0, 0, SAFE_DIVIDE(MAX(lp_cust_all.new_cust_per_country), MAX(lp_cust_reg_dereg
        .cm_total_new_reg_cnt))) * 100, 3) AS lp_active_cust,
   ROUND(IF(MAX(lp_recp.all_total_net_val) = 0, 0, SAFE_DIVIDE(MAX(lp_recp.lp_total_net_val), MAX(lp_recp.all_total_net_val
        ))) * 100, 3) AS lp_revenue_share_perc,
   ROUND(IF(MAX(lp_recp.all_num_recp) = 0, 0, SAFE_DIVIDE(MAX(lp_recp.lp_num_recp), MAX(lp_recp.all_num_recp))) * 100, 3
    ) AS lp_bon_id_rate,
   ROUND(IF(MAX(lp_cust_all.reg_cust) = 0, 0, SAFE_DIVIDE(MAX(lp_recp.lp_num_recp), MAX(lp_cust_all.reg_cust))), 3) AS
   lp_buying_freq,
   ROUND(IF(MAX(lp_cust_all.reg_cust) = 0, 0, SAFE_DIVIDE(MAX(lp_recp.lp_total_net_val), MAX(lp_cust_all.reg_cust))), 3
    ) AS lp_revnue_per_cust,
   ROUND(IF(MAX(lp_recp.lp_num_recp) = 0, 0, SAFE_DIVIDE(MAX(lp_recp.lp_total_net_val), MAX(lp_recp.lp_num_recp))), 3)
   AS lp_avg_bon,
   ROUND(IF(MAX(lp_recp.non_lp_num_recp) = 0, 0, SAFE_DIVIDE(MAX(lp_recp.non_lp_total_net_val), MAX(lp_recp.non_lp_num_recp
       ))), 3) AS non_lp_avg_bon,
   ROUND(IF(MAX(lp_recp.lp_num_recp) + MAX(lp_recp.non_lp_num_recp) = 0, 0, SAFE_DIVIDE(MAX(lp_recp.lp_total_net_val) +
       MAX(lp_recp.non_lp_total_net_val), MAX(lp_recp.lp_num_recp) + MAX(lp_recp.non_lp_num_recp))), 3) AS all_avg_bon
  FROM LP_CUST_ALL AS lp_cust_all
   FULL JOIN LP_RECP_DISC AS lp_recp_disc ON lp_cust_all.client_id = lp_recp_disc.client_id AND lp_cust_all.cy_month =
     lp_recp_disc.cy_month
   FULL JOIN LP_RECP AS lp_recp ON COALESCE(lp_cust_all.client_id, lp_recp_disc.client_id) = lp_recp.client_id AND
     COALESCE(lp_cust_all.cy_month, lp_recp_disc.cy_month) = lp_recp.cy_month
   FULL JOIN LP_CUST_REG_DEREG AS lp_cust_reg_dereg ON COALESCE(lp_cust_all.client_id, lp_recp_disc.client_id, lp_recp.client_id
      ) = lp_cust_reg_dereg.client_id AND COALESCE(lp_cust_all.cy_month, lp_recp_disc.cy_month, lp_recp.cy_month) =
     lp_cust_reg_dereg.cy_month
   FULL JOIN LD_DWNLOAD AS ld_dwnload ON COALESCE(lp_cust_all.client_id, lp_recp_disc.client_id, lp_recp.client_id,
      lp_cust_reg_dereg.client_id) = ld_dwnload.client_id AND COALESCE(lp_cust_all.cy_month, lp_recp_disc.cy_month,
      lp_recp.cy_month, lp_cust_reg_dereg.cy_month) = ld_dwnload.cy_month
   FULL JOIN STORE_PER_CLIENT AS store_per_client ON COALESCE(lp_cust_all.client_id, lp_recp_disc.client_id, lp_recp.client_id
      , lp_cust_reg_dereg.client_id, ld_dwnload.client_id) = store_per_client.client_id AND COALESCE(lp_cust_all.cy_month
      , lp_recp_disc.cy_month, lp_recp.cy_month, lp_cust_reg_dereg.cy_month, ld_dwnload.cy_month) = store_per_client.cy_month
     
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead_1 AS R_CL6 ON COALESCE(lp_cust_all.client_id, lp_recp_disc.client_id
     , lp_recp.client_id, lp_cust_reg_dereg.client_id, ld_dwnload.client_id, store_per_client.client_id) = R_CL6.client_id
    
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_month_desc_1 AS CMD ON COALESCE(lp_cust_all.cy_month, lp_recp_disc.cy_month,
     lp_recp.cy_month, lp_cust_reg_dereg.cy_month, ld_dwnload.cy_month, store_per_client.cy_month) = CMD.cy_month
  GROUP BY R_CL6.client_id,
   client_desc,
   R_CL6.country_iso_cd,
   CMD.cy_month,
   CMD.cy_month_name,
   year);