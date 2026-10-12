/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_LP_ORGA_OHNE_COUPON_2
#----------------------------------------------------------------------------
# History:
#  1.0  26.08.2024    Ulrich Ross               Init
#  1.1  06.06.2024    Ulrich Ross               Add DIV0
#                                               User Story 711243
#     
#                                                                                
#----------------------------------------------------------------------------
*/


-- LP Preisveränderung und Abschriften_2 IN LW (Werbe-PV and pcwo_reason_id = 41)

CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_lp_orga_ohne_coupon_2 AS WITH WERBE_PV AS (SELECT CAL.cy_month,
   R_CL.client_id,
   SUM(CASE
     WHEN RCPT_LP_DAY.lidlplus_cust_fg IN ('N') AND RCPT_LP_DAY.pcwo_reason_id IN (41)
     THEN RCPT_LP_DAY.discount_val
     ELSE NULL
     END) AS non_lp_discount_val_wpv,
   SUM(CASE
     WHEN RCPT_LP_DAY.lidlplus_cust_fg IN ('Y') AND RCPT_LP_DAY.pcwo_reason_id IN (41)
     THEN RCPT_LP_DAY.discount_val
     ELSE NULL
     END) AS lp_discount_val_wpv,
   SUM(CASE
     WHEN RCPT_LP_DAY.pcwo_reason_id IN (41)
     THEN RCPT_LP_DAY.discount_val
     ELSE NULL
     END) AS all_discount_val_wpv,
   SUM(CASE
     WHEN RCPT_LP_DAY.lidlplus_cust_fg = 'N'
     THEN RCPT_LP_DAY.writeoff_val
     ELSE NULL
     END) AS non_lp_writeoff_val_wpv,
   SUM(CASE
     WHEN RCPT_LP_DAY.lidlplus_cust_fg = 'Y'
     THEN RCPT_LP_DAY.writeoff_val
     ELSE NULL
     END) AS lp_writeoff_val_wpv,
   SUM(RCPT_LP_DAY.writeoff_val) AS all_writeoff_val_wpv
  FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_rcpt_hdr_ldpl_day_2 AS RCPT_LP_DAY
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday_2 AS CAL ON RCPT_LP_DAY.dwh_cal_dt = CAL.dat_calendar
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead_2 AS R_CL ON RCPT_LP_DAY.client_id = R_CL.client_id
  WHERE RCPT_LP_DAY.aspect_id IN (2)
   AND CAL.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_2
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_2
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
   AND RCPT_LP_DAY.curr_tot_id = 0
   AND R_CL.dashboard_relevant_fg = 1
  GROUP BY CAL.cy_month,
   R_CL.client_id), PV_TNV AS (SELECT CAL0.cy_month,
   R_CL0.client_id,
   SUM(CASE
     WHEN RCPT_LP_DAY0.lidlplus_cust_fg = 'Y'
     THEN RCPT_LP_DAY0.discount_val
     ELSE NULL
     END) AS lp_discount_val,
   SUM(CASE
     WHEN RCPT_LP_DAY0.lidlplus_cust_fg = 'Y'
     THEN RCPT_LP_DAY0.total_net_val
     ELSE NULL
     END) AS lp_total_net_val,
   SUM(CASE
     WHEN RCPT_LP_DAY0.lidlplus_cust_fg = 'N'
     THEN RCPT_LP_DAY0.discount_val
     ELSE NULL
     END) AS non_lp_discount_val,
   SUM(CASE
     WHEN RCPT_LP_DAY0.lidlplus_cust_fg = 'N'
     THEN RCPT_LP_DAY0.total_net_val
     ELSE NULL
     END) AS non_lp_total_net_val,
   SUM(RCPT_LP_DAY0.discount_val) AS all_discount_val,
   SUM(RCPT_LP_DAY0.total_net_val) AS all_total_net_val
  FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_client_rcpt_hdr_ldpl_day_2 AS RCPT_LP_DAY0
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday_2 AS CAL0 ON RCPT_LP_DAY0.dwh_cal_dt = CAL0.dat_calendar
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead_2 AS R_CL0 ON RCPT_LP_DAY0.client_id = R_CL0.client_id
  WHERE RCPT_LP_DAY0.aspect_id IN (2)
   AND CAL0.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_2
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_2
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
   AND RCPT_LP_DAY0.curr_tot_id = 0
   AND R_CL0.dashboard_relevant_fg = 1
  GROUP BY CAL0.cy_month,
   R_CL0.client_id), COUNT_RECEIPT_CUST AS (SELECT RCPT_LP_ITEM_DAY.cy_month,
   R_CL2.client_id,
   RCPT_LP_ITEM_DAY.lidlplus_cust_fg,
   COUNT(DISTINCT RCPT_LP_ITEM_DAY.receipt_cnt) AS count_receipt,
    CASE
    WHEN 1.00001 / 1.00001 * COUNT(DISTINCT RCPT_LP_ITEM_DAY.customer_sid) = 0
    THEN NULL
    ELSE 1.00001 / 1.00001 * COUNT(DISTINCT RCPT_LP_ITEM_DAY.customer_sid)
    END AS count_customer
  FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_client_store_rcpt_item_ldpl_day_2 AS RCPT_LP_ITEM_DAY
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead_2 AS R_CL2 ON RCPT_LP_ITEM_DAY.client_id = R_CL2.client_id
  WHERE RCPT_LP_ITEM_DAY.aspect_id IN (2)
   AND RCPT_LP_ITEM_DAY.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_2
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_2
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
   AND R_CL2.dashboard_relevant_fg = 1
  GROUP BY RCPT_LP_ITEM_DAY.cy_month,
   RCPT_LP_ITEM_DAY.lidlplus_cust_fg,
   R_CL2.client_id), LP_WO_RC AS (SELECT COALESCE(werbe_pv.cy_month, count_receipt0.cy_month) AS cy_month,
   COALESCE(werbe_pv.client_id, count_receipt0.client_id) AS client_id,
   werbe_pv.non_lp_writeoff_val_wpv,
   count_receipt0.count_receipt AS lp_count_receipt
  FROM WERBE_PV AS werbe_pv
   FULL JOIN COUNT_RECEIPT_CUST AS count_receipt0 ON werbe_pv.client_id = count_receipt0.client_id AND werbe_pv.cy_month
      = count_receipt0.cy_month
  WHERE count_receipt0.lidlplus_cust_fg = 'Y'), LP_WO_WPV_NON_LP_CR_TNV AS (SELECT COALESCE(werbe_pv.cy_month,
    count_receipt0.cy_month, pv_tnv.cy_month) AS cy_month,
   COALESCE(werbe_pv.client_id, count_receipt0.client_id, pv_tnv.client_id) AS client_id,
   werbe_pv.lp_writeoff_val_wpv,
   count_receipt0.count_receipt AS non_lp_count_receipt,
   pv_tnv.non_lp_total_net_val
  FROM WERBE_PV AS werbe_pv
   FULL JOIN COUNT_RECEIPT_CUST AS count_receipt0 ON werbe_pv.client_id = count_receipt0.client_id AND werbe_pv.cy_month
      = count_receipt0.cy_month
   FULL JOIN PV_TNV AS pv_tnv ON COALESCE(werbe_pv.client_id, count_receipt0.client_id) = pv_tnv.client_id AND COALESCE(werbe_pv
      .cy_month, count_receipt0.cy_month) = pv_tnv.cy_month
  WHERE count_receipt0.lidlplus_cust_fg = 'N'), ALL_WO_CR AS (SELECT COALESCE(werbe_pv.cy_month, count_receipt0.cy_month
    ) AS cy_month,
   COALESCE(werbe_pv.client_id, count_receipt0.client_id) AS client_id,
   werbe_pv.all_writeoff_val_wpv,
   SUM(count_receipt0.count_receipt) AS all_receipt_count
  FROM WERBE_PV AS werbe_pv
   FULL JOIN COUNT_RECEIPT_CUST AS count_receipt0 ON werbe_pv.client_id = count_receipt0.client_id AND werbe_pv.cy_month
      = count_receipt0.cy_month
  GROUP BY cy_month,
   client_id,
   werbe_pv.all_writeoff_val_wpv), LP_CC AS (SELECT cy_month,
   client_id,
   SUM(count_customer) AS lp_count_customer
  FROM COUNT_RECEIPT_CUST AS count_receipt_cust
  GROUP BY cy_month,
   client_id), LP_REG_DEREG AS (SELECT LP_CUST_REG_DEREG.cy_month,
   R_CL9.client_id,
   SUM(CAST(LP_CUST_REG_DEREG.cm_dereg_cnt AS BIGNUMERIC)) AS lp_cust_dereg_count,
   SUM(CAST(LP_CUST_REG_DEREG.cm_total_new_reg_cnt AS BIGNUMERIC)) AS lp_total_new_reg_count,
   SUM(CAST(LP_CUST_REG_DEREG.cm_reg_cnt AS BIGNUMERIC)) AS lp_reg_count
  FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_cust_reg_dereg_ldpl_mth_2 AS LP_CUST_REG_DEREG
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead_2 AS R_CL9 ON LP_CUST_REG_DEREG.client_id = R_CL9.client_id
  WHERE LP_CUST_REG_DEREG.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_2
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_2
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
   AND R_CL9.dashboard_relevant_fg = 1
  GROUP BY LP_CUST_REG_DEREG.cy_month,
   R_CL9.client_id), STORE_MOVE AS (SELECT STORE_OPEN_MONTH.cy_month,
   R_CL10.client_id,
   COUNT(DISTINCT CAST(STORE_OPEN_MONTH.client_id AS STRING) || '_' || CAST(STORE_OPEN_MONTH.move_to_store_id AS STRING)
     ) AS client_move_to_store
  FROM ldl_p_lew_mart_lidl_digital_ac.v_store_open_month_2 AS STORE_OPEN_MONTH
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead_2 AS R_CL10 ON STORE_OPEN_MONTH.client_id = R_CL10.client_id
  WHERE STORE_OPEN_MONTH.cm_mth_ending_str_open_fg = 1
   AND STORE_OPEN_MONTH.aspect_id IN (2)
   AND R_CL10.dashboard_relevant_fg = 1
   AND STORE_OPEN_MONTH.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_2
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_2
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
  GROUP BY STORE_OPEN_MONTH.cy_month,
   R_CL10.client_id) (-- LIDL PLUS WriteOff und receipt count

  -- LIDL PLUS WriteOff Werbe-pv and NON LIDL PLUS receipt count and total net

  -- all count receipt (berechnet) and write off (Werbe-PV)
 -- LIDL PLUS count receipt

  -- LIDL PLUS customer registration and deregistration
 -- Store move to store

  -- Bericht: Non-Lidl Plus Werbe-PV MAX(pa13.wjxbfs1)  wjxbfs1

  -- Bericht: Lidl Plus Werbe-PV MAX(pa13.wjxbfs2)  wjxbfs2
 -- Bericht: Gesamt Werbe-PV MAX(pa13.wjxbfs3)  wjxbfs3

  -- Bericht: Non-Lidl Plus Werbe-PV (%)
 -- Bericht: Lidl Plus Werbe-PV (%)
 -- Bericht: Gesamt Werbe-PV (%)

  -- Bericht: Lidl Plus Preisveränderung MAX(pa14.wjxbfs1)  wjxbfs4

  -- Bericht: Non-Lidl Plus Preisveränderung MAX(pa14.wjxbfs3)  wjxbfs5

  -- Bericht: Gesamt Preisveränderung MAX(pa14.wjxbfs5)  wjxbfs6

  -- Bericht: Non-Lidl Plus Abschriften_2 Gesamt MAX(pa17.wjxbfs1)  wjxbfs7

  -- Bericht: Lidl Plus Abschriften_2 Gesamt MAX(pa18.wjxbfs1)  wjxbfs8

  -- Bericht: Gesamt Abschriften_2  MAX(pa19.wjxbfs1)  wjxbfs9
 -- Bericht: Non-Lidl Plus Abschriften_2 Gesamt (%)  wjxbfs7

  -- Bericht: Lidl Plus Abschriften_2 Gesamt (%)  wjxbfs8
 -- Bericht: Gesamt Abschriften_2  (%)

  -- Bericht: Lidl Plus Kunden (Anz.) MAX(pa110.wjxbfs1) wjxbfsa all_count_customer

  -- Bericht: dv. Anteil Lidl Plus Kunden (%)
 -- Bericht: Gesamt Preisveränderung (%)

  -- Bericht: Lidl Plus Preisveränderung(%)
 -- Bericht: Non-Lidl Plus Preisveränderung (%)

  -- Bericht: Lidl Plus De-Registrierungen (Anz.) MAX(pa111.wjxbfs1)  wjxbfsb
 -- MAX(pa18.wjxbfs2)  wjxbfsd

  -- Bericht: Lidl Plus Umsatz EJR, MAX(pa14.wjxbfs2)  wjxbfse
 -- Bericht: Lidl Plus Ø Bon (LW/Bon)

  -- Bericht: Gesamt Ø Bon (LW/Bon)
 -- Bericht: Non-Lidl Plus Ø Bon (LW/Bon)

  -- Bericht: Lidl Plus Bon Identifizierungsrate
 -- Bericht: Lidl Plus Einkaufsfrequenz (Bon/Kunde)

  -- Bericht: Lidl Plus Umsatzanteil (%)
 -- Bericht: Lidl Plus Bon (Anz.) MAX(pa17.wjxbfs2)  wjxbfsf

  -- MAX(pa19.wjxbfs2)  wjxbfs10
 -- Bericht: Gesamt Umsatz EJR (LW) LJ MAX(pa14.wjxbfs6)  wjxbfs11

  -- Bericht: Lidl Plus registrierte Nutzer (Anz.) MAX(pa111.wjxbfs2)  wjxbfs12

  -- Bericht: Non-Lidl Plus Umsatz EJR MAX(pa18.wjxbfs3)  wjxbfs13

  -- Bericht: Filialen (Anz.) LJ MAX(pa115.wjxbfs1)  wjxbfs14

  -- Bericht: Lidl Plus Neu-Registrierungen (Anz.) MAX(pa111.wjxbfs3)  wjxbfs15
 SELECT R_CL11.client_id,
   R_CL11.country_desc,
   R_CL11.country_iso_cd,
   CAL5.cy_month,
   CAL5.cy_month_name,
   ROUND(MAX(werbe_pv.non_lp_discount_val_wpv), 2) AS non_lp_werbe_pv,
   ROUND(MAX(werbe_pv.lp_discount_val_wpv), 2) AS lp_werbe_pv,
   ROUND(MAX(werbe_pv.all_discount_val_wpv), 2) AS gesamt_werbe_pv,
   ROUND(IF(MAX(pv_tnv.all_total_net_val) = 0, 0, SAFE_DIVIDE(MAX(werbe_pv.non_lp_discount_val_wpv), MAX(pv_tnv.all_total_net_val
        ))) * 100, 2) AS non_lp_werbe_pv_prozent,
   ROUND(IF(MAX(pv_tnv.all_total_net_val) = 0, 0, SAFE_DIVIDE(MAX(werbe_pv.lp_discount_val_wpv), MAX(pv_tnv.all_total_net_val
        ))) * 100, 2) AS lp_werbe_pv_prozent,
   ROUND(IF(MAX(pv_tnv.all_total_net_val) = 0, 0, SAFE_DIVIDE(MAX(werbe_pv.all_discount_val_wpv), MAX(pv_tnv.all_total_net_val
        ))) * 100, 2) AS gesamt_werbe_pv_prozent,
   ROUND(MAX(pv_tnv.lp_discount_val), 2) AS lp_preisveraenderung,
   ROUND(MAX(pv_tnv.non_lp_discount_val), 2) AS non_lp_preisveraenderung,
   ROUND(MAX(pv_tnv.all_discount_val), 2) AS gesamt_preisveraenderung,
   ROUND(MAX(lp_wo_rc.non_lp_writeoff_val_wpv), 2) AS non_lp_abschriften,
   ROUND(MAX(lp_wo_wpv_non_lp_cr_tnv.lp_writeoff_val_wpv), 2) AS lp_abschriften,
   ROUND(MAX(all_wo_cr.all_writeoff_val_wpv), 2) AS gesamt_abschriften,
   ROUND(IF(MAX(pv_tnv.all_total_net_val) = 0, 0, SAFE_DIVIDE(MAX(lp_wo_rc.non_lp_writeoff_val_wpv), MAX(pv_tnv.all_total_net_val
        ))) * 100, 2) AS non_lp_abschriften_prozent,
   ROUND(IF(MAX(pv_tnv.all_total_net_val) = 0, 0, SAFE_DIVIDE(MAX(lp_wo_wpv_non_lp_cr_tnv.lp_writeoff_val_wpv), MAX(pv_tnv
        .all_total_net_val))) * 100, 2) AS lp_abschriften_prozent,
   ROUND(IF(MAX(pv_tnv.all_total_net_val) = 0, 0, SAFE_DIVIDE(MAX(all_wo_cr.all_writeoff_val_wpv), MAX(pv_tnv.all_total_net_val
        ))) * 100, 2) AS gesamt_abschriften_prozent,
   CAST(ROUND(MAX(lp_cc.lp_count_customer), 0) AS INTEGER) AS lp_kunden_anz,
   ROUND(IF(MAX(lp_reg_dereg.lp_total_new_reg_count) = 0, 0, SAFE_DIVIDE(MAX(lp_cc.lp_count_customer), MAX(lp_reg_dereg
        .lp_total_new_reg_count))) * 100, 2) AS dv_anteil_lp_kunden_prozent,
   ROUND(IF(MAX(pv_tnv.all_total_net_val) = 0, 0, SAFE_DIVIDE(MAX(pv_tnv.all_discount_val), MAX(pv_tnv.all_total_net_val
        ))) * 100, 2) AS gesamt_preisveraenderung_prozent,
   ROUND(IF(MAX(pv_tnv.all_total_net_val) = 0, 0, SAFE_DIVIDE(MAX(pv_tnv.lp_discount_val), MAX(pv_tnv.all_total_net_val
        ))) * 100, 2) AS lp_preisveraenderung_prozent,
   ROUND(IF(MAX(pv_tnv.all_total_net_val) = 0, 0, SAFE_DIVIDE(MAX(pv_tnv.non_lp_discount_val), MAX(pv_tnv.all_total_net_val
        ))) * 100, 2) AS non_lp_preisveraenderung_prozent,
   MAX(lp_reg_dereg.lp_cust_dereg_count) AS lp_deregistrierung_anz,
   MAX(all_wo_cr.all_receipt_count) AS gesamt_bon_anz,
   MAX(lp_wo_wpv_non_lp_cr_tnv.non_lp_count_receipt) AS non_lp_count_receipt,
   CAST(ROUND(MAX(pv_tnv.lp_total_net_val), 0) AS INTEGER) AS lp_umsatz_ejr,
   ROUND(IF(MAX(lp_wo_rc.lp_count_receipt) = 0, 0, SAFE_DIVIDE(MAX(pv_tnv.lp_total_net_val), MAX(lp_wo_rc.lp_count_receipt
       ))), 2) AS lp_bon_durchschn,
   ROUND(IF(MAX(all_wo_cr.all_receipt_count) = 0, 0, SAFE_DIVIDE(MAX(pv_tnv.all_total_net_val), MAX(all_wo_cr.all_receipt_count
       ))), 2) AS gesamt_bon_durchschn,
   ROUND(IF(MAX(lp_wo_wpv_non_lp_cr_tnv.non_lp_count_receipt) = 0, 0, SAFE_DIVIDE(MAX(lp_wo_wpv_non_lp_cr_tnv.non_lp_total_net_val
       ), MAX(lp_wo_wpv_non_lp_cr_tnv.non_lp_count_receipt))), 2) AS non_lp_bon_durchschn,
   ROUND(IF(MAX(all_wo_cr.all_receipt_count) = 0, 0, SAFE_DIVIDE(MAX(lp_wo_rc.lp_count_receipt), MAX(all_wo_cr.all_receipt_count
        ))) * 100, 2) AS lp_bon_identifizierungsrate,
   ROUND(IF(MAX(lp_cc.lp_count_customer) = 0, 0, SAFE_DIVIDE(MAX(lp_wo_rc.lp_count_receipt), MAX(lp_cc.lp_count_customer
       ))), 2) AS lp_einkaufsfrequenz,
   ROUND(IF(MAX(pv_tnv.all_total_net_val) = 0, 0, SAFE_DIVIDE(MAX(pv_tnv.lp_total_net_val), MAX(pv_tnv.all_total_net_val
        ))) * 100, 2) AS lp_umsatzanteil_prozent,
   MAX(lp_wo_rc.lp_count_receipt) AS lp_bon_anz,
   MAX(all_wo_cr.all_receipt_count) AS all_receipt_count,
   CAST(ROUND(MAX(pv_tnv.all_total_net_val), 0) AS INTEGER) AS gesamt_umsatz_ejr,
   MAX(lp_reg_dereg.lp_total_new_reg_count) AS lp_registrierte_nutzer_anz,
   CAST(ROUND(MAX(lp_wo_wpv_non_lp_cr_tnv.non_lp_total_net_val), 0) AS INTEGER) AS non_lp_umsatz_ejr,
   CAST(ROUND(MAX(store_move.client_move_to_store), 0) AS INTEGER) AS filialen_anz,
   MAX(lp_reg_dereg.lp_reg_count) AS lp_neuregistrierungen_anz
  FROM WERBE_PV AS werbe_pv
   FULL JOIN PV_TNV AS pv_tnv ON werbe_pv.client_id = pv_tnv.client_id AND werbe_pv.cy_month = pv_tnv.cy_month
   FULL JOIN LP_WO_RC AS lp_wo_rc ON COALESCE(werbe_pv.client_id, pv_tnv.client_id) = lp_wo_rc.client_id AND COALESCE(werbe_pv
      .cy_month, pv_tnv.cy_month) = lp_wo_rc.cy_month
   FULL JOIN LP_WO_WPV_NON_LP_CR_TNV AS lp_wo_wpv_non_lp_cr_tnv ON COALESCE(werbe_pv.client_id, pv_tnv.client_id) =
     lp_wo_wpv_non_lp_cr_tnv.client_id AND COALESCE(werbe_pv.cy_month, pv_tnv.cy_month) = lp_wo_wpv_non_lp_cr_tnv.cy_month
     
   FULL JOIN ALL_WO_CR AS all_wo_cr ON COALESCE(werbe_pv.client_id, pv_tnv.client_id, lp_wo_wpv_non_lp_cr_tnv.client_id
      ) = all_wo_cr.client_id AND COALESCE(werbe_pv.cy_month, pv_tnv.cy_month, lp_wo_wpv_non_lp_cr_tnv.cy_month) =
     all_wo_cr.cy_month
   FULL JOIN LP_CC AS lp_cc ON COALESCE(werbe_pv.client_id, pv_tnv.client_id, lp_wo_wpv_non_lp_cr_tnv.client_id,
      all_wo_cr.client_id) = lp_cc.client_id AND COALESCE(werbe_pv.cy_month, pv_tnv.cy_month, lp_wo_wpv_non_lp_cr_tnv.cy_month
      , all_wo_cr.cy_month) = lp_cc.cy_month
   FULL JOIN LP_REG_DEREG AS lp_reg_dereg ON COALESCE(werbe_pv.client_id, pv_tnv.client_id, lp_wo_wpv_non_lp_cr_tnv.client_id
      , all_wo_cr.client_id, lp_cc.client_id) = lp_reg_dereg.client_id AND COALESCE(werbe_pv.cy_month, pv_tnv.cy_month,
      lp_wo_wpv_non_lp_cr_tnv.cy_month, all_wo_cr.cy_month, lp_cc.cy_month) = lp_reg_dereg.cy_month
   FULL JOIN STORE_MOVE AS store_move ON COALESCE(werbe_pv.client_id, pv_tnv.client_id, lp_wo_wpv_non_lp_cr_tnv.client_id
      , all_wo_cr.client_id, lp_cc.client_id, lp_reg_dereg.client_id) = store_move.client_id AND COALESCE(werbe_pv.cy_month
      , pv_tnv.cy_month, lp_wo_wpv_non_lp_cr_tnv.cy_month, all_wo_cr.cy_month, lp_cc.cy_month, lp_reg_dereg.cy_month) =
     store_move.cy_month
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead_2 AS R_CL11 ON COALESCE(werbe_pv.client_id, pv_tnv.client_id,
     lp_wo_wpv_non_lp_cr_tnv.client_id, all_wo_cr.client_id, lp_cc.client_id, lp_reg_dereg.client_id, store_move.client_id
     ) = R_CL11.client_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_month_desc_2 AS CAL5 ON COALESCE(werbe_pv.cy_month, pv_tnv.cy_month,
     lp_wo_wpv_non_lp_cr_tnv.cy_month, all_wo_cr.cy_month, lp_cc.cy_month, lp_reg_dereg.cy_month, store_move.cy_month) =
    CAL5.cy_month
  GROUP BY R_CL11.client_id,
   R_CL11.country_desc,
   R_CL11.country_iso_cd,
   CAL5.cy_month,
   CAL5.cy_month_name
  ORDER BY 4 DESC NULLS FIRST);