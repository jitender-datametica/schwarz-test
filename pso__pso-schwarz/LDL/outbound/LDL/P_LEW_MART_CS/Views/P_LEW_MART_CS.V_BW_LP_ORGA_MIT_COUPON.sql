/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_LP_ORGA_MIT_COUPON
#----------------------------------------------------------------------------
# History:
#  1.0  26.08.2024    Ulrich Ross               Init
#  1.1  06.06.2024    Ulrich Ross               Add DIV0
#                                               User Story 711243     
#                                                                                
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_lp_orga_mit_coupon AS WITH LP_VALUES AS (SELECT LDPL_DAY.cy_month,
   R_CL.client_id,
   LDPL_DAY.feature_id,
   LDPL_DAY.discount_type_id,
   LDPL_DAY.coupon_type_id,
   COUNT(DISTINCT LDPL_DAY.receipt_total_net_val_uniq) AS receipt_total_net_val_uniq,
    CASE
    WHEN SUM(LDPL_DAY.discount_val) = 0
    THEN NULL
    ELSE ROUND(SUM(LDPL_DAY.discount_val), 2)
    END AS discount_val,
    CASE
    WHEN SUM(LDPL_DAY.writeoff_val) = 0
    THEN NULL
    ELSE ROUND(SUM(LDPL_DAY.writeoff_val), 2)
    END AS writeoff_val,
   ROUND(1.00001 / 1.00001 * COUNT(DISTINCT LDPL_DAY.customer_sid)) AS count_customer,
    CASE
    WHEN LDPL_DAY.pcwo_reason_id IN (41) AND SUM(LDPL_DAY.discount_val) = 0
    THEN NULL
    WHEN LDPL_DAY.pcwo_reason_id IN (41) AND SUM(LDPL_DAY.discount_val) <> 0
    THEN SUM(LDPL_DAY.discount_val)
    ELSE NULL
    END AS lp_val_werbepv,
    CASE
    WHEN LDPL_DAY.pcwo_reason_id IN (43) AND SUM(LDPL_DAY.discount_val) = 0
    THEN NULL
    WHEN LDPL_DAY.pcwo_reason_id IN (43) AND SUM(LDPL_DAY.discount_val) <> 0
    THEN SUM(LDPL_DAY.discount_val)
    ELSE NULL
    END AS lp_val_restantenverwert_sort,
    CASE
    WHEN LDPL_DAY.pcwo_reason_id IN (6, 81, 151) AND SUM(LDPL_DAY.writeoff_val) = 0
    THEN NULL
    WHEN LDPL_DAY.pcwo_reason_id IN (6, 81, 151) AND SUM(LDPL_DAY.writeoff_val) <> 0
    THEN SUM(LDPL_DAY.writeoff_val)
    ELSE NULL
    END AS lp_val_restantenverwert_aktion
  FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_rcpt_coupon_promo_discount_ldpl_day AS LDPL_DAY
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead AS R_CL ON LDPL_DAY.client_id = R_CL.client_id
  WHERE LDPL_DAY.lidlplus_cust_fg = 'Y'
   AND LDPL_DAY.aspect_id IN (2)
   AND LDPL_DAY.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
   AND LDPL_DAY.curr_tot_id = 0
   AND R_CL.dashboard_relevant_fg = 1
  GROUP BY LDPL_DAY.cy_month,
   LDPL_DAY.feature_id,
   LDPL_DAY.coupon_type_id,
   LDPL_DAY.discount_type_id,
   LDPL_DAY.pcwo_reason_id,
   R_CL.client_id), LP_CUSTOMER AS (SELECT LDPL_DAY0.cy_month,
   R_CL0.client_id,
   LDPL_DAY0.feature_id,
   LDPL_DAY0.discount_type_id,
   LDPL_DAY0.coupon_type_id,
     1.00001 / 1.00001 * COUNT(DISTINCT LDPL_DAY0.customer_sid) AS count_customer
  FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_rcpt_coupon_promo_discount_ldpl_day AS LDPL_DAY0
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead AS R_CL0 ON LDPL_DAY0.client_id = R_CL0.client_id
  WHERE LDPL_DAY0.lidlplus_cust_fg = 'Y'
   AND LDPL_DAY0.aspect_id IN (2)
   AND LDPL_DAY0.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
   AND LDPL_DAY0.curr_tot_id = 0
   AND R_CL0.dashboard_relevant_fg = 1
  GROUP BY LDPL_DAY0.cy_month,
   LDPL_DAY0.feature_id,
   LDPL_DAY0.coupon_type_id,
   LDPL_DAY0.discount_type_id,
   R_CL0.client_id), LP_UMSATZ AS (SELECT CAL.cy_month,
   R_CL1.client_id,
    CASE
    WHEN SUM(LP_RCPT.total_net_val) = 0
    THEN NULL
    ELSE ROUND(SUM(LP_RCPT.total_net_val), 2)
    END AS lp_total_net_val
  FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_client_rcpt_hdr_ldpl_day AS LP_RCPT
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday AS CAL ON LP_RCPT.dwh_cal_dt = CAL.dat_calendar
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead AS R_CL1 ON LP_RCPT.client_id = R_CL1.client_id
  WHERE LP_RCPT.aspect_id IN (2)
   AND CAL.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
   AND LP_RCPT.curr_tot_id = 0
   AND R_CL1.dashboard_relevant_fg = 1
  GROUP BY CAL.cy_month,
   R_CL1.client_id) (-- Preisveraenderungen
 -- Restantenverwertung (PV) Sortiment

  -- Restantenverwertung (PV) Aktion  = 6
 -- Restantenverwertung (PV) Lager - Aktion  = 81

  -- Restantenverwertung Vollabschrift (GTIN switch) = 151
 -- Berichtsname: Lidl Plus Bon (Anz.) mit LP Aktion LJ

  -- Berichtsname:  Lidl Plus Einlöser (Anz.) mit LP Aktion LJ

  -- Berichtsname:  Lidl Plus Preisveränderung (LW) mit LP Aktion LJ

  -- Berichtsname: Lidl Plus Preisveränderung (%) mit LP Aktion LJ

  -- Berichtsname: Lidl Plus Werbe-PV (LW) mit LP Aktion LJ
 -- Berichtsname: Lidl Plus Werbe-PV (%) mit LP Aktion LJ

  -- Berichtsname: Lidl Plus Restantenverwertung (PV) Sortiment (LW) mit LP Aktion LJ

  -- Berichtsname:  Lidl Plus Restantenverwertung (PV) Sortiment (%) mit LP Aktion LJ

  -- Berichtsname: Lidl Plus Abschriften Gesamt (LW) mit LP Aktion LJ

  -- Berichtsname: Lidl Plus Abschriften Gesamt (%) mit LP Aktion LJ

  -- Berichtsname: Lidl Plus Restantenverwertung (PV) Aktion (LW) mit LP Aktion LJ

  -- Berichtsname: Lidl Plus Restantenverwertung (PV) Aktion (%) mit LP Aktion LJ
 SELECT R_CL2.client_id,
   R_CL2.country_desc AS client_desc,
   R_CL2.country_iso_cd,
   CAL0.cy_month,
   CAL0.cy_month_name,
   LP_COUPON_TYPE.coupon_type_id,
   LP_COUPON_TYPE.coupon_type_desc,
   LP_COUPON_TYPE_SUBGROUP.coupon_type_group_id,
   LP_COUPON_TYPE_GROUP.coupon_type_group_desc,
   LP_COUPON_TYPE.coupon_type_subgroup_id,
   LP_COUPON_TYPE_SUBGROUP.coupon_type_subgroup_desc,
   LP_FEATURE.feature_id,
   LP_FEATURE.feature_desc,
   LP_FEATURE_SUBGROUP.feature_group_id,
   LP_FEATURE_GROUP.feature_group_desc,
   LP_FEATURE.feature_subgroup_id,
   LP_FEATURE_SUBGROUP.feature_subgroup_desc,
   LP_DISCOUNT_TYPE.discount_type_id,
   LP_DISCOUNT_TYPE.discount_type_desc,
   LP_FEATURE_GROUP.loyalty_id,
   LP_FEATURE_GROUP_LOYALTY.loyalty_desc,
   SUM(lp_values.receipt_total_net_val_uniq) AS receipt_total_net_val_uniq,
   ROUND(MAX(lp_customer.count_customer)) AS count_customer,
   ROUND(MAX(lp_values.discount_val)) AS lp_preisveraenderung_aktion,
   ROUND(CASE
     WHEN COALESCE(IF(CASE
           WHEN MAX(lp_umsatz.lp_total_net_val) = 0
           THEN NULL
           ELSE MAX(lp_umsatz.lp_total_net_val)
           END = 0, 0, SAFE_DIVIDE(MAX(lp_values.discount_val), CASE
           WHEN MAX(lp_umsatz.lp_total_net_val) = 0
           THEN NULL
           ELSE MAX(lp_umsatz.lp_total_net_val)
           END)) * 100.0, 0) = 0
     THEN NULL
     ELSE COALESCE(MAX(lp_values.discount_val) / CASE
         WHEN MAX(lp_umsatz.lp_total_net_val) = 0
         THEN NULL
         ELSE MAX(lp_umsatz.lp_total_net_val)
         END * 100.0, 0)
     END, 2) AS lp_preisveraenderung_aktion_prozent,
   ROUND(MAX(lp_values.lp_val_werbepv)) AS lp_werbepv_aktion,
   ROUND(CASE
     WHEN COALESCE(IF(CASE
           WHEN MAX(lp_umsatz.lp_total_net_val) = 0
           THEN NULL
           ELSE MAX(lp_umsatz.lp_total_net_val)
           END = 0, 0, SAFE_DIVIDE(MAX(lp_values.lp_val_werbepv), CASE
           WHEN MAX(lp_umsatz.lp_total_net_val) = 0
           THEN NULL
           ELSE MAX(lp_umsatz.lp_total_net_val)
           END)) * 100.0, 0) = 0
     THEN NULL
     ELSE COALESCE(MAX(lp_values.lp_val_werbepv) / CASE
         WHEN MAX(lp_umsatz.lp_total_net_val) = 0
         THEN NULL
         ELSE MAX(lp_umsatz.lp_total_net_val)
         END * 100.0, 0)
     END, 2) AS lp_werbe_pv_aktion_prozent,
   ROUND(MAX(lp_values.lp_val_restantenverwert_sort)) AS lp_restantenverwert_sort,
   ROUND(CASE
     WHEN COALESCE(IF(CASE
           WHEN MAX(lp_umsatz.lp_total_net_val) = 0
           THEN NULL
           ELSE MAX(lp_umsatz.lp_total_net_val)
           END = 0, 0, SAFE_DIVIDE(MAX(lp_values.lp_val_restantenverwert_sort), CASE
           WHEN MAX(lp_umsatz.lp_total_net_val) = 0
           THEN NULL
           ELSE MAX(lp_umsatz.lp_total_net_val)
           END)) * 100.0, 0) = 0
     THEN NULL
     ELSE COALESCE(MAX(lp_values.lp_val_restantenverwert_sort) / CASE
         WHEN MAX(lp_umsatz.lp_total_net_val) = 0
         THEN NULL
         ELSE MAX(lp_umsatz.lp_total_net_val)
         END * 100.0, 0)
     END, 2) AS lp_restantenverwert_sort_prozent,
   ROUND(MAX(lp_values.writeoff_val)) AS lp_abschriften_gesamt,
   ROUND(CASE
     WHEN COALESCE(IF(CASE
           WHEN MAX(lp_umsatz.lp_total_net_val) = 0
           THEN NULL
           ELSE MAX(lp_umsatz.lp_total_net_val)
           END = 0, 0, SAFE_DIVIDE(MAX(lp_values.writeoff_val), CASE
           WHEN MAX(lp_umsatz.lp_total_net_val) = 0
           THEN NULL
           ELSE MAX(lp_umsatz.lp_total_net_val)
           END)) * 100.0, 0) = 0
     THEN NULL
     ELSE COALESCE(MAX(lp_values.writeoff_val) / CASE
         WHEN MAX(lp_umsatz.lp_total_net_val) = 0
         THEN NULL
         ELSE MAX(lp_umsatz.lp_total_net_val)
         END * 100.0, 0)
     END, 2) AS lp_abschriften_gesamt_prozent,
   ROUND(MAX(lp_values.lp_val_restantenverwert_aktion)) AS lp_val_restantenverwert_aktion,
   ROUND(CASE
     WHEN COALESCE(IF(CASE
           WHEN MAX(lp_umsatz.lp_total_net_val) = 0
           THEN NULL
           ELSE MAX(lp_umsatz.lp_total_net_val)
           END = 0, 0, SAFE_DIVIDE(MAX(lp_values.lp_val_restantenverwert_aktion), CASE
           WHEN MAX(lp_umsatz.lp_total_net_val) = 0
           THEN NULL
           ELSE MAX(lp_umsatz.lp_total_net_val)
           END)) * 100.0, 0) = 0
     THEN NULL
     ELSE COALESCE(MAX(lp_values.lp_val_restantenverwert_aktion) / CASE
         WHEN MAX(lp_umsatz.lp_total_net_val) = 0
         THEN NULL
         ELSE MAX(lp_umsatz.lp_total_net_val)
         END * 100.0, 0)
     END, 2) AS lp_restantenverwert_aktion_prozent_prozent
  FROM LP_VALUES AS lp_values
   FULL JOIN LP_CUSTOMER AS lp_customer ON lp_values.client_id = lp_customer.client_id AND lp_values.coupon_type_id =
        lp_customer.coupon_type_id AND lp_values.cy_month = lp_customer.cy_month AND lp_values.discount_type_id =
      lp_customer.discount_type_id AND lp_values.feature_id = lp_customer.feature_id
   LEFT JOIN LP_UMSATZ AS lp_umsatz ON lp_values.client_id = lp_umsatz.client_id AND lp_values.cy_month = lp_umsatz.cy_month
     
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_coupon_type AS LP_COUPON_TYPE ON lp_values.coupon_type_id =
    LP_COUPON_TYPE.coupon_type_id
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_subgroup AS LP_COUPON_TYPE_SUBGROUP ON LP_COUPON_TYPE.coupon_type_subgroup_id
     = LP_COUPON_TYPE_SUBGROUP.coupon_type_subgroup_id
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_feature AS LP_FEATURE ON lp_values.feature_id = LP_FEATURE.feature_id
    
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_feature_subgroup AS LP_FEATURE_SUBGROUP ON LP_FEATURE.feature_subgroup_id
     = LP_FEATURE_SUBGROUP.feature_subgroup_id
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_feature_group AS LP_FEATURE_GROUP ON LP_FEATURE_SUBGROUP.feature_group_id
     = LP_FEATURE_GROUP.feature_group_id
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_discount_type AS LP_DISCOUNT_TYPE ON lp_values.discount_type_id =
    LP_DISCOUNT_TYPE.discount_type_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead AS R_CL2 ON lp_values.client_id = R_CL2.client_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_month_desc AS CAL0 ON lp_values.cy_month = CAL0.cy_month
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_group AS LP_COUPON_TYPE_GROUP ON LP_COUPON_TYPE_SUBGROUP
    .coupon_type_group_id = LP_COUPON_TYPE_GROUP.coupon_type_group_id
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_feature_group_loyalty AS LP_FEATURE_GROUP_LOYALTY ON LP_FEATURE_GROUP
    .loyalty_id = LP_FEATURE_GROUP_LOYALTY.loyalty_id
  GROUP BY R_CL2.client_id,
   client_desc,
   R_CL2.country_iso_cd,
   CAL0.cy_month,
   CAL0.cy_month_name,
   LP_COUPON_TYPE.coupon_type_id,
   LP_COUPON_TYPE.coupon_type_desc,
   LP_COUPON_TYPE_SUBGROUP.coupon_type_group_id,
   LP_COUPON_TYPE_GROUP.coupon_type_group_desc,
   LP_COUPON_TYPE.coupon_type_subgroup_id,
   LP_COUPON_TYPE_SUBGROUP.coupon_type_subgroup_desc,
   LP_FEATURE.feature_id,
   LP_FEATURE.feature_desc,
   LP_FEATURE_SUBGROUP.feature_group_id,
   LP_FEATURE_GROUP.feature_group_desc,
   LP_FEATURE.feature_subgroup_id,
   LP_FEATURE_SUBGROUP.feature_subgroup_desc,
   LP_DISCOUNT_TYPE.discount_type_id,
   LP_DISCOUNT_TYPE.discount_type_desc,
   LP_FEATURE_GROUP.loyalty_id,
   LP_FEATURE_GROUP_LOYALTY.loyalty_desc
  ORDER BY 1 NULLS LAST,
   4 NULLS LAST,
   6 NULLS LAST,
   8 NULLS LAST,
   10 NULLS LAST,
   12 NULLS LAST,
   14 NULLS LAST,
   16 NULLS LAST,
   18 NULLS LAST,
   20 NULLS LAST);