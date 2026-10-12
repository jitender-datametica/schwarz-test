CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_lp_item_mit_coupon_1 AS WITH LP_ITM_DR AS (SELECT SUB_ITM.itemgroup_int_id,
   LDPL_DAY.cy_month,
   ITM.client_id,
   LDPL_DAY.feature_id,
   LDPL_DAY.discount_type_id,
   LP_CT.coupon_type_id,
   SUM(DISTINCT LDPL_DAY.receipt_item_discount_piece_weight_qty_uniq) AS itm_discount_receipt,
   ROUND(SUM(DISTINCT LDPL_DAY.receipt_total_net_val_item_uniq), 5) AS itm_net_receipt
  FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_rcpt_coupon_promo_discount_ldpl_day_1 AS LDPL_DAY
   INNER JOIN ldl_p_lew_mart_lead_ac.v_itm_item_1 AS ITM ON LDPL_DAY.client_id = ITM.client_id AND LDPL_DAY.item_sid = ITM
     .item_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_subitemgroup_1 AS SUB_ITM ON ITM.subitemgroup_id = SUB_ITM.subitemgroup_id
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_1 AS LP_CT ON LDPL_DAY.coupon_type_id = LP_CT.coupon_type_id
    
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_subgroup_1 AS LP_CTS ON LP_CT.coupon_type_subgroup_id =
    LP_CTS.coupon_type_subgroup_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead_1 AS R_CL ON ITM.client_id = R_CL.client_id
  WHERE LDPL_DAY.curr_tot_id = 0
   AND LDPL_DAY.aspect_id IN (2)
   AND SUB_ITM.itemgroup_int_id IN (- 1000, - 4, - 3, - 2, 0, 10, 20, 30, 32, 40, 50, 60, 70, 80, 90)
   AND LP_CTS.coupon_type_group_id IN (0, 1, 2, 3, 4)
   AND R_CL.dashboard_relevant_fg = 1
   AND LDPL_DAY.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_1
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_1
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
  GROUP BY SUB_ITM.itemgroup_int_id,
   LDPL_DAY.cy_month,
   ITM.client_id,
   LDPL_DAY.feature_id,
   LDPL_DAY.discount_type_id,
   LP_CT.coupon_type_id), CUST_C_TYP AS (SELECT SUB_ITM0.itemgroup_int_id,
   LDPL_DAY0.cy_month,
   ITM0.client_id,
   LDPL_DAY0.feature_id,
   LDPL_DAY0.discount_type_id,
   LP_CT0.coupon_type_id,
     1.00001 / 1.00001 * COUNT(DISTINCT CASE
      WHEN LP_CTS0.coupon_type_group_id IN (2, 3, 4)
      THEN LDPL_DAY0.customer_sid
      ELSE NULL
      END) AS cust_c_typ_1,
   MAX(CASE
     WHEN LP_CTS0.coupon_type_group_id IN (2, 3, 4)
     THEN 1
     ELSE 0
     END) AS c_typ_1,
     1.00001 / 1.00001 * COUNT(DISTINCT CASE
      WHEN LP_CTS0.coupon_type_group_id IN (0, 1, 2, 3, 4)
      THEN LDPL_DAY0.customer_sid
      ELSE NULL
      END) AS cust_c_typ_2,
   MAX(CASE
     WHEN LP_CTS0.coupon_type_group_id IN (0, 1, 2, 3, 4)
     THEN 1
     ELSE 0
     END) AS c_typ_2,
    CASE
    WHEN SUM(LDPL_DAY0.discount_val) = 0
    THEN NULL
    ELSE SUM(LDPL_DAY0.discount_val)
    END AS discount_val,
    CASE
    WHEN SUM(LDPL_DAY0.writeoff_val) = 0
    THEN NULL
    ELSE SUM(LDPL_DAY0.writeoff_val)
    END AS writeoff_val,
   COUNT(DISTINCT LDPL_DAY0.receipt_total_net_val_uniq) AS total_net_val
  FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_rcpt_coupon_promo_discount_ldpl_day_1 AS LDPL_DAY0
   INNER JOIN ldl_p_lew_mart_lead_ac.v_itm_item_1 AS ITM0 ON LDPL_DAY0.client_id = ITM0.client_id AND LDPL_DAY0.item_sid =
     ITM0.item_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_subitemgroup_1 AS SUB_ITM0 ON ITM0.subitemgroup_id = SUB_ITM0.subitemgroup_id
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_1 AS LP_CT0 ON LDPL_DAY0.coupon_type_id = LP_CT0.coupon_type_id
    
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_subgroup_1 AS LP_CTS0 ON LP_CT0.coupon_type_subgroup_id =
    LP_CTS0.coupon_type_subgroup_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday_1 AS A16 ON LDPL_DAY0.dwh_cal_dt = A16.dat_calendar
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead_1 AS R_CL0 ON ITM0.client_id = R_CL0.client_id
  WHERE LDPL_DAY0.lidlplus_cust_fg = 'Y'
   AND LDPL_DAY0.curr_tot_id = 0
   AND LDPL_DAY0.aspect_id IN (2)
   AND SUB_ITM0.itemgroup_int_id IN (- 1000, - 4, - 3, - 2, 0, 10, 20, 30, 32, 40, 50, 60, 70, 80, 90)
   AND R_CL0.dashboard_relevant_fg = 1
   AND LP_CTS0.coupon_type_group_id IN (0, 1, 2, 3, 4)
   AND LDPL_DAY0.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_1
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_1
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
  GROUP BY SUB_ITM0.itemgroup_int_id,
   LDPL_DAY0.cy_month,
   ITM0.client_id,
   LDPL_DAY0.feature_id,
   LDPL_DAY0.discount_type_id,
   LP_CT0.coupon_type_id), LP_PWCO AS (SELECT SUB_ITM1.itemgroup_int_id,
   LDPL_DAY1.cy_month,
   ITM1.client_id,
   LDPL_DAY1.feature_id,
   LDPL_DAY1.discount_type_id,
   LP_CT1.coupon_type_id,
    CASE
    WHEN LDPL_DAY1.pcwo_reason_id = 41
    THEN CASE
     WHEN SUM(LDPL_DAY1.discount_val) = 0
     THEN NULL
     ELSE SUM(LDPL_DAY1.discount_val)
     END
    ELSE NULL
    END AS lp_41_discount_receipt,
    CASE
    WHEN LDPL_DAY1.pcwo_reason_id = 43
    THEN CASE
     WHEN SUM(LDPL_DAY1.discount_val) = 0
     THEN NULL
     ELSE SUM(LDPL_DAY1.discount_val)
     END
    ELSE NULL
    END AS lp_43_discount_receipt,
    CASE
    WHEN LDPL_DAY1.pcwo_reason_id IN (6, 81, 151)
    THEN CASE
     WHEN SUM(LDPL_DAY1.writeoff_val) = 0
     THEN NULL
     ELSE SUM(LDPL_DAY1.writeoff_val)
     END
    ELSE NULL
    END AS lp_writeoff
  FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_rcpt_coupon_promo_discount_ldpl_day_1 AS LDPL_DAY1
   INNER JOIN ldl_p_lew_mart_lead_ac.v_itm_item_1 AS ITM1 ON LDPL_DAY1.client_id = ITM1.client_id AND LDPL_DAY1.item_sid =
     ITM1.item_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_subitemgroup_1 AS SUB_ITM1 ON ITM1.subitemgroup_id = SUB_ITM1.subitemgroup_id
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_1 AS LP_CT1 ON LDPL_DAY1.coupon_type_id = LP_CT1.coupon_type_id
    
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_subgroup_1 AS LP_CTS1 ON LP_CT1.coupon_type_subgroup_id =
    LP_CTS1.coupon_type_subgroup_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead_1 AS R_CL1 ON ITM1.client_id = R_CL1.client_id
  WHERE LDPL_DAY1.pcwo_reason_id IN (41, 43, 6, 81, 151)
   AND LDPL_DAY1.lidlplus_cust_fg IN ('Y')
   AND LDPL_DAY1.curr_tot_id = 0
   AND LDPL_DAY1.aspect_id IN (2)
   AND SUB_ITM1.itemgroup_int_id IN (- 1000, - 4, - 3, - 2, 0, 10, 20, 30, 32, 40, 50, 60, 70, 80, 90)
   AND LP_CTS1.coupon_type_group_id IN (0, 1, 2, 3, 4)
   AND R_CL1.dashboard_relevant_fg = 1
   AND LDPL_DAY1.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_1
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_1
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
  GROUP BY SUB_ITM1.itemgroup_int_id,
   LDPL_DAY1.cy_month,
   ITM1.client_id,
   LDPL_DAY1.feature_id,
   LDPL_DAY1.discount_type_id,
   LP_CT1.coupon_type_id,
   LDPL_DAY1.pcwo_reason_id), LP_ITMGRP_DR AS (SELECT COALESCE(pldpl_day.itemgroup_int_id, cust_c_typ.itemgroup_int_id)
   AS itemgroup_int_id,
   COALESCE(pldpl_day.cy_month, cust_c_typ.cy_month) AS cy_month,
   R_CL4.client_id,
   COALESCE(pldpl_day.feature_id, cust_c_typ.feature_id) AS feature_id,
   COALESCE(pldpl_day.discount_type_id, cust_c_typ.discount_type_id) AS discount_type_id,
   LP_CT4.coupon_type_id,
   COALESCE(pldpl_day.itm_net_receipt / CASE
      WHEN cust_c_typ.total_net_val = 0
      THEN NULL
      ELSE cust_c_typ.total_net_val
      END, 0) AS discount_receipt
  FROM LP_ITM_DR AS pldpl_day
   FULL JOIN CUST_C_TYP AS cust_c_typ ON pldpl_day.client_id = cust_c_typ.client_id AND pldpl_day.coupon_type_id =
         cust_c_typ.coupon_type_id AND pldpl_day.cy_month = cust_c_typ.cy_month AND pldpl_day.discount_type_id =
       cust_c_typ.discount_type_id AND pldpl_day.feature_id = cust_c_typ.feature_id AND pldpl_day.itemgroup_int_id =
     cust_c_typ.itemgroup_int_id
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_1 AS LP_CT4 ON COALESCE(pldpl_day.coupon_type_id,
     cust_c_typ.coupon_type_id) = LP_CT4.coupon_type_id
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_subgroup_1 AS LP_CTS4 ON LP_CT4.coupon_type_subgroup_id =
    LP_CTS4.coupon_type_subgroup_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead_1 AS R_CL4 ON COALESCE(pldpl_day.client_id, cust_c_typ.client_id) =
    R_CL4.client_id
  WHERE R_CL4.dashboard_relevant_fg = 1
   AND COALESCE(pldpl_day.itemgroup_int_id, cust_c_typ.itemgroup_int_id) IN (- 1000, - 4, - 3, - 2, 0, 10, 20, 30, 32,
     40, 50, 60, 70, 80, 90)
   AND LP_CTS4.coupon_type_group_id IN (0, 1, 2, 3, 4)), LP_CUST_C_TYP2 AS (SELECT coupon_type_id,
   discount_type_id,
   feature_id,
   client_id,
   cy_month,
   itemgroup_int_id,
   cust_c_typ_2
  FROM CUST_C_TYP AS cust_c_typ), LP_NET_VAL AS (SELECT SUB_ITM5.itemgroup_int_id,
   LDPL_DAY5.cy_month,
   ORG.client_id,
    CASE
    WHEN SUM(LDPL_DAY5.total_net_val) = 0
    THEN NULL
    ELSE SUM(LDPL_DAY5.total_net_val)
    END AS total_net_val
  FROM ldl_p_lew_mart_lidl_digital_ac.v_agg_client_store_item_ldpl_day_1 AS LDPL_DAY5
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_all_store_merge_1 AS ORG ON LDPL_DAY5.aspect_id = ORG.aspect_id AND LDPL_DAY5.client_id
       = ORG.client_id AND LDPL_DAY5.move_to_store_id = ORG.move_to_store_id
   INNER JOIN ldl_p_lew_mart_lead_ac.v_itm_item_1 AS ITM5 ON LDPL_DAY5.client_id = ITM5.client_id AND LDPL_DAY5.item_sid =
      ITM5.item_id AND ORG.client_id = ITM5.client_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_subitemgroup_1 AS SUB_ITM5 ON ITM5.subitemgroup_id = SUB_ITM5.subitemgroup_id
  WHERE ORG.aspect_id IN (2)
   AND LDPL_DAY5.curr_tot_id = 0
   AND ORG.dashboard_relevant_fg = 1
   AND SUB_ITM5.itemgroup_int_id IN (- 1000, - 4, - 3, - 2, 0, 10, 20, 30, 32, 40, 50, 60, 70, 80, 90)
   AND LDPL_DAY5.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_1
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_1
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
  GROUP BY SUB_ITM5.itemgroup_int_id,
   LDPL_DAY5.cy_month,
   ORG.client_id) (-- , lp_artikelebene AS (
 SELECT LDPL_DAY40.client_id,
   LDPL_DAY40.country_desc AS client_desc,
   LDPL_DAY40.country_iso_cd,
   LDPL_DAY50.cy_month,
   LDPL_DAY50.cy_month_name,
   LP_CT6.coupon_type_id,
   LP_CT6.coupon_type_desc,
   LDPL_DAY00.coupon_type_group_id,
   LDPL_DAY7.coupon_type_group_desc,
   LP_CT6.coupon_type_subgroup_id,
   LDPL_DAY00.coupon_type_subgroup_desc,
   LDPL_DAY10.feature_id,
   LDPL_DAY10.feature_desc,
   LDPL_DAY20.feature_group_id,
   LDPL_DAY8.feature_group_desc,
   LDPL_DAY10.feature_subgroup_id,
   LDPL_DAY20.feature_subgroup_desc,
   LDPL_DAY30.discount_type_id,
   LDPL_DAY30.discount_type_desc,
   LDPL_DAY8.loyalty_id,
   LP_FEATURE_GROUP_LOYALTY.loyalty_desc,
   LDPL_DAY6.itemgroup_int_id,
   LDPL_DAY6.itemgroup_int_desc,
   ROUND(MAX(pldpl_day.itm_discount_receipt)) AS lidl_plus_abverkauf_bereinigt_ejr_mit_lp_aktion_lj,
   ROUND(MAX(pldpl_day.itm_net_receipt)) AS lidl_plus_umsatz_ejr_mit_lp_aktion_lj,
   ROUND(MAX(cust_c_typ.discount_val)) AS lidl_plus_preisveraenderung_mit_lp_aktion_lj,
   ROUND(CASE
     WHEN COALESCE(IF(CASE
           WHEN MAX(lp_net_val.total_net_val) = 0
           THEN NULL
           ELSE MAX(lp_net_val.total_net_val)
           END = 0, 0, SAFE_DIVIDE(MAX(cust_c_typ.discount_val), CASE
           WHEN MAX(lp_net_val.total_net_val) = 0
           THEN NULL
           ELSE MAX(lp_net_val.total_net_val)
           END)) * 100.0, 0) = 0
     THEN NULL
     ELSE COALESCE(MAX(cust_c_typ.discount_val) / CASE
         WHEN MAX(lp_net_val.total_net_val) = 0
         THEN NULL
         ELSE MAX(lp_net_val.total_net_val)
         END * 100.0, 0)
     END, 2) AS lidl_plus_preisveraenderung_mit_lp_aktion_lj_per,
   ROUND(MAX(lp_pwco.lp_41_discount_receipt)) AS lidl_plus_werbe_pv_mit_lp_aktion_lj,
   ROUND(CASE
     WHEN COALESCE(IF(CASE
           WHEN MAX(lp_net_val.total_net_val) = 0
           THEN NULL
           ELSE MAX(lp_net_val.total_net_val)
           END = 0, 0, SAFE_DIVIDE(MAX(lp_pwco.lp_41_discount_receipt), CASE
           WHEN MAX(lp_net_val.total_net_val) = 0
           THEN NULL
           ELSE MAX(lp_net_val.total_net_val)
           END)) * 100.0, 0) = 0
     THEN NULL
     ELSE COALESCE(MAX(lp_pwco.lp_41_discount_receipt) / CASE
         WHEN MAX(lp_net_val.total_net_val) = 0
         THEN NULL
         ELSE MAX(lp_net_val.total_net_val)
         END * 100.0, 0)
     END, 2) AS lidl_plus_werbe_pv_mit_lp_aktion_lj_per,
   ROUND(MAX(lp_pwco.lp_43_discount_receipt)) AS lidl_plus_restantenverwertung_sortiment_mit_lp_aktion_lj,
   ROUND(CASE
     WHEN COALESCE(IF(CASE
           WHEN MAX(lp_net_val.total_net_val) = 0
           THEN NULL
           ELSE MAX(lp_net_val.total_net_val)
           END = 0, 0, SAFE_DIVIDE(MAX(lp_pwco.lp_43_discount_receipt), CASE
           WHEN MAX(lp_net_val.total_net_val) = 0
           THEN NULL
           ELSE MAX(lp_net_val.total_net_val)
           END)) * 100.0, 0) = 0
     THEN NULL
     ELSE COALESCE(MAX(lp_pwco.lp_43_discount_receipt) / CASE
         WHEN MAX(lp_net_val.total_net_val) = 0
         THEN NULL
         ELSE MAX(lp_net_val.total_net_val)
         END * 100.0, 0)
     END, 2) AS lidl_plus_restantenverwertung_sortiment_mit_lp_aktion_lj_per,
   ROUND(MAX(cust_c_typ.writeoff_val)) AS lidl_plus_abschriften_gesamt_mit_lp_aktion_lj,
   ROUND(CASE
     WHEN COALESCE(IF(CASE
           WHEN MAX(lp_net_val.total_net_val) = 0
           THEN NULL
           ELSE MAX(lp_net_val.total_net_val)
           END = 0, 0, SAFE_DIVIDE(MAX(cust_c_typ.writeoff_val), CASE
           WHEN MAX(lp_net_val.total_net_val) = 0
           THEN NULL
           ELSE MAX(lp_net_val.total_net_val)
           END)) * 100.0, 0) = 0
     THEN NULL
     ELSE COALESCE(MAX(cust_c_typ.writeoff_val) / CASE
         WHEN MAX(lp_net_val.total_net_val) = 0
         THEN NULL
         ELSE MAX(lp_net_val.total_net_val)
         END * 100.0, 0)
     END, 2) AS lidl_plus_abschriften_gesamt_mit_lp_aktion_lj_per,
   ROUND(MAX(lp_pwco.lp_writeoff)) AS lidl_plus_restantenverwertung_aktion_mit_lp_aktion_lj,
   ROUND(CASE
     WHEN COALESCE(IF(CASE
           WHEN MAX(lp_net_val.total_net_val) = 0
           THEN NULL
           ELSE MAX(lp_net_val.total_net_val)
           END = 0, 0, SAFE_DIVIDE(MAX(lp_pwco.lp_writeoff), CASE
           WHEN MAX(lp_net_val.total_net_val) = 0
           THEN NULL
           ELSE MAX(lp_net_val.total_net_val)
           END)) * 100.0, 0) = 0
     THEN NULL
     ELSE COALESCE(MAX(lp_pwco.lp_writeoff) / CASE
         WHEN MAX(lp_net_val.total_net_val) = 0
         THEN NULL
         ELSE MAX(lp_net_val.total_net_val)
         END * 100.0, 0)
     END, 2) AS lidl_plus_restantenverwertung_aktion_mit_lp_aktion_lj_per,
   ROUND(MAX(cust_c_typ.total_net_val)) AS lidl_plus_bon_mit_lp_aktion_lj,
   ROUND(MAX(lp_itmgrp_dr.discount_receipt), 2) AS lidl_plus_bon_lw_mit_lp_aktionlj,
   ROUND(MAX(lp_cust_c_typ2.cust_c_typ_2)) AS lidl_plus_einloeser_mit_lp_aktion_lj
  FROM LP_ITM_DR AS pldpl_day
   FULL JOIN CUST_C_TYP AS cust_c_typ ON pldpl_day.client_id = cust_c_typ.client_id AND pldpl_day.coupon_type_id =
         cust_c_typ.coupon_type_id AND pldpl_day.cy_month = cust_c_typ.cy_month AND pldpl_day.discount_type_id =
       cust_c_typ.discount_type_id AND pldpl_day.feature_id = cust_c_typ.feature_id AND pldpl_day.itemgroup_int_id =
     cust_c_typ.itemgroup_int_id
   FULL JOIN LP_PWCO AS lp_pwco ON COALESCE(pldpl_day.client_id, cust_c_typ.client_id) = lp_pwco.client_id AND COALESCE(pldpl_day
          .coupon_type_id, cust_c_typ.coupon_type_id) = lp_pwco.coupon_type_id AND COALESCE(pldpl_day.cy_month,
         cust_c_typ.cy_month) = lp_pwco.cy_month AND COALESCE(pldpl_day.discount_type_id, cust_c_typ.discount_type_id) =
       lp_pwco.discount_type_id AND COALESCE(pldpl_day.feature_id, cust_c_typ.feature_id) = lp_pwco.feature_id AND
     COALESCE(pldpl_day.itemgroup_int_id, cust_c_typ.itemgroup_int_id) = lp_pwco.itemgroup_int_id
   FULL JOIN LP_ITMGRP_DR AS lp_itmgrp_dr ON COALESCE(pldpl_day.client_id, cust_c_typ.client_id, lp_pwco.client_id) =
         lp_itmgrp_dr.client_id AND COALESCE(pldpl_day.coupon_type_id, cust_c_typ.coupon_type_id, lp_pwco.coupon_type_id
          ) = lp_itmgrp_dr.coupon_type_id AND COALESCE(pldpl_day.cy_month, cust_c_typ.cy_month, lp_pwco.cy_month) =
        lp_itmgrp_dr.cy_month AND COALESCE(pldpl_day.discount_type_id, cust_c_typ.discount_type_id, lp_pwco.discount_type_id
        ) = lp_itmgrp_dr.discount_type_id AND COALESCE(pldpl_day.feature_id, cust_c_typ.feature_id, lp_pwco.feature_id)
      = lp_itmgrp_dr.feature_id AND COALESCE(pldpl_day.itemgroup_int_id, cust_c_typ.itemgroup_int_id, lp_pwco.itemgroup_int_id
      ) = lp_itmgrp_dr.itemgroup_int_id
   FULL JOIN LP_CUST_C_TYP2 AS lp_cust_c_typ2 ON COALESCE(pldpl_day.client_id, cust_c_typ.client_id, lp_pwco.client_id,
          lp_itmgrp_dr.client_id) = lp_cust_c_typ2.client_id AND COALESCE(pldpl_day.coupon_type_id, cust_c_typ.coupon_type_id
          , lp_pwco.coupon_type_id, lp_itmgrp_dr.coupon_type_id) = lp_cust_c_typ2.coupon_type_id AND COALESCE(pldpl_day
         .cy_month, cust_c_typ.cy_month, lp_pwco.cy_month, lp_itmgrp_dr.cy_month) = lp_cust_c_typ2.cy_month AND COALESCE(pldpl_day
        .discount_type_id, cust_c_typ.discount_type_id, lp_pwco.discount_type_id, lp_itmgrp_dr.discount_type_id) =
       lp_cust_c_typ2.discount_type_id AND COALESCE(pldpl_day.feature_id, cust_c_typ.feature_id, lp_pwco.feature_id,
       lp_itmgrp_dr.feature_id) = lp_cust_c_typ2.feature_id AND COALESCE(pldpl_day.itemgroup_int_id, cust_c_typ.itemgroup_int_id
      , lp_pwco.itemgroup_int_id, lp_itmgrp_dr.itemgroup_int_id) = lp_cust_c_typ2.itemgroup_int_id
   LEFT JOIN LP_NET_VAL AS lp_net_val ON COALESCE(pldpl_day.client_id, cust_c_typ.client_id, lp_pwco.client_id,
       lp_itmgrp_dr.client_id, lp_cust_c_typ2.client_id) = lp_net_val.client_id AND COALESCE(pldpl_day.cy_month,
       cust_c_typ.cy_month, lp_pwco.cy_month, lp_itmgrp_dr.cy_month, lp_cust_c_typ2.cy_month) = lp_net_val.cy_month AND
     COALESCE(pldpl_day.itemgroup_int_id, cust_c_typ.itemgroup_int_id, lp_pwco.itemgroup_int_id, lp_itmgrp_dr.itemgroup_int_id
      , lp_cust_c_typ2.itemgroup_int_id) = lp_net_val.itemgroup_int_id
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_1 AS LP_CT6 ON COALESCE(pldpl_day.coupon_type_id,
     cust_c_typ.coupon_type_id, lp_pwco.coupon_type_id, lp_itmgrp_dr.coupon_type_id, lp_cust_c_typ2.coupon_type_id) =
    LP_CT6.coupon_type_id
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_subgroup_1 AS LDPL_DAY00 ON LP_CT6.coupon_type_subgroup_id
    = LDPL_DAY00.coupon_type_subgroup_id
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_feature_1 AS LDPL_DAY10 ON COALESCE(pldpl_day.feature_id, cust_c_typ.feature_id
     , lp_pwco.feature_id, lp_itmgrp_dr.feature_id, lp_cust_c_typ2.feature_id) = LDPL_DAY10.feature_id
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_feature_subgroup_1 AS LDPL_DAY20 ON LDPL_DAY10.feature_subgroup_id =
    LDPL_DAY20.feature_subgroup_id
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_discount_type_1 AS LDPL_DAY30 ON COALESCE(pldpl_day.discount_type_id,
     cust_c_typ.discount_type_id, lp_pwco.discount_type_id, lp_itmgrp_dr.discount_type_id, lp_cust_c_typ2.discount_type_id
     ) = LDPL_DAY30.discount_type_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead_1 AS LDPL_DAY40 ON COALESCE(pldpl_day.client_id, cust_c_typ.client_id
     , lp_pwco.client_id, lp_itmgrp_dr.client_id, lp_cust_c_typ2.client_id) = LDPL_DAY40.client_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_month_desc_1 AS LDPL_DAY50 ON COALESCE(pldpl_day.cy_month, cust_c_typ.cy_month,
     lp_pwco.cy_month, lp_itmgrp_dr.cy_month, lp_cust_c_typ2.cy_month) = LDPL_DAY50.cy_month
   INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_itemgroup_int_1 AS LDPL_DAY6 ON COALESCE(pldpl_day.itemgroup_int_id, cust_c_typ
     .itemgroup_int_id, lp_pwco.itemgroup_int_id, lp_itmgrp_dr.itemgroup_int_id, lp_cust_c_typ2.itemgroup_int_id) =
    LDPL_DAY6.itemgroup_int_id
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_coupon_type_group_1 AS LDPL_DAY7 ON LDPL_DAY00.coupon_type_group_id =
    LDPL_DAY7.coupon_type_group_id
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_feature_group_1 AS LDPL_DAY8 ON LDPL_DAY20.feature_group_id = LDPL_DAY8
    .feature_group_id
   INNER JOIN ldl_p_lew_process_mstr_ac.v_ref_ldpl_feature_group_loyalty_1 AS LP_FEATURE_GROUP_LOYALTY ON LDPL_DAY8.loyalty_id
     = LP_FEATURE_GROUP_LOYALTY.loyalty_id
  GROUP BY LDPL_DAY40.client_id,
   client_desc,
   LDPL_DAY40.country_iso_cd,
   LDPL_DAY50.cy_month,
   LDPL_DAY50.cy_month_name,
   LP_CT6.coupon_type_id,
   LP_CT6.coupon_type_desc,
   LDPL_DAY00.coupon_type_group_id,
   LDPL_DAY7.coupon_type_group_desc,
   LP_CT6.coupon_type_subgroup_id,
   LDPL_DAY00.coupon_type_subgroup_desc,
   LDPL_DAY10.feature_id,
   LDPL_DAY10.feature_desc,
   LDPL_DAY20.feature_group_id,
   LDPL_DAY8.feature_group_desc,
   LDPL_DAY10.feature_subgroup_id,
   LDPL_DAY20.feature_subgroup_desc,
   LDPL_DAY30.discount_type_id,
   LDPL_DAY30.discount_type_desc,
   LDPL_DAY6.itemgroup_int_id,
   LDPL_DAY6.itemgroup_int_desc,
   LDPL_DAY8.loyalty_id,
   LP_FEATURE_GROUP_LOYALTY.loyalty_desc);
