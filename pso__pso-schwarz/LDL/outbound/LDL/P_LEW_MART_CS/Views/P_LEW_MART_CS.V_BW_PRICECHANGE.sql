/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_PRICECHANGE
#----------------------------------------------------------------------------
# History:
#  1.0  16.08.2023    Ulrich Ross               Init
#                                               User Story 501417
#  1.1  05.09.2023    Ulrich Ross               Add DIV0 
#                                               User Story 501417                                                                                
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_pricechange AS WITH ITEM_PRICECHANGE AS (SELECT IG_PCH.itemgroup_int_id,
   CAL.cy_month,
   WH.client_id,
   SUM(CASE
     WHEN IG_PCH.sfotype_id IN (134, 144, 180, 190, 186, 196) AND IG_PCH.pcwo_reason_id IN (42) AND CASE
        WHEN IG_PCH.client_id IN (12)
        THEN IG_PCH.pch_bnl_switch_fg
        WHEN IG_PCH.client_id NOT IN (12)
        THEN 1
        ELSE 0
        END IN (1)
     THEN IG_PCH.val_price_change
     ELSE NULL
     END) AS perm_price_change,
   SUM(CASE
     WHEN IG_PCH.sfotype_id IN (134, 144, 180, 190) AND IG_PCH.pcwo_reason_id IN (43) AND CASE
        WHEN IG_PCH.client_id IN (12)
        THEN IG_PCH.pch_bnl_switch_fg
        WHEN IG_PCH.client_id NOT IN (12)
        THEN 1
        ELSE 0
        END IN (1)
     THEN IG_PCH.val_price_change
     ELSE NULL
     END) AS remain_price_change,
   SUM(CASE
     WHEN IG_PCH.sfotype_id IN (- 99) AND CASE
        WHEN IG_PCH.client_id IN (12)
        THEN IG_PCH.pch_bnl_switch_fg
        WHEN IG_PCH.client_id NOT IN (12)
        THEN 1
        ELSE 0
        END = 1
     THEN IG_PCH.val_price_change
     ELSE NULL
     END) AS price_reg_diff,
   SUM(CASE
     WHEN IG_PCH.sfotype_id IN (134, 144, 180, 190) AND CASE
         WHEN IG_PCH.client_id IN (12)
         THEN IG_PCH.pch_bnl_switch_fg
         WHEN IG_PCH.client_id NOT IN (12)
         THEN 1
         ELSE 0
         END = 1 AND IG_PCH.pcwo_reason_id IN (41)
     THEN IG_PCH.val_price_change
     ELSE NULL
     END) AS adver_price_change
  FROM ldl_p_lew_mart_lead_ac.v_agg_wh_day_itemgroup_pch AS IG_PCH
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_wh_merge AS WH ON IG_PCH.aspect_id = WH.aspect_id AND IG_PCH.client_id = WH.client_id
       AND IG_PCH.wh_id = WH.wh_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_currency AS CURR ON IG_PCH.client_id = CURR.client_id AND IG_PCH.currency_iso_cd
       = CURR.currency_iso_cd AND CURR.curr_tot_id = 0
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday AS CAL ON IG_PCH.dwh_cal_dt = CAL.dat_calendar
  WHERE WH.aspect_id = 2
   AND CAL.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
   AND WH.dashboard_relevant_fg = 1
   AND (IG_PCH.sfotype_id IN (134, 144, 180, 190, 186, 196) AND IG_PCH.pcwo_reason_id IN (42) AND CASE
          WHEN IG_PCH.client_id IN (12)
          THEN IG_PCH.pch_bnl_switch_fg
          WHEN IG_PCH.client_id NOT IN (12)
          THEN 1
          ELSE 0
          END IN (1) OR IG_PCH.sfotype_id IN (134, 144, 180, 190) AND IG_PCH.pcwo_reason_id IN (43) AND CASE
          WHEN IG_PCH.client_id IN (12)
          THEN IG_PCH.pch_bnl_switch_fg
          WHEN IG_PCH.client_id NOT IN (12)
          THEN 1
          ELSE 0
          END IN (1) OR IG_PCH.sfotype_id IN (- 99) AND CASE
         WHEN IG_PCH.client_id IN (12)
         THEN IG_PCH.pch_bnl_switch_fg
         WHEN IG_PCH.client_id NOT IN (12)
         THEN 1
         ELSE 0
         END = 1 OR IG_PCH.sfotype_id IN (134, 144, 180, 190) AND CASE
         WHEN IG_PCH.client_id IN (12)
         THEN IG_PCH.pch_bnl_switch_fg
         WHEN IG_PCH.client_id NOT IN (12)
         THEN 1
         ELSE 0
         END = 1 AND IG_PCH.pcwo_reason_id IN (41))
  GROUP BY IG_PCH.itemgroup_int_id,
   CAL.cy_month,
   WH.client_id), VAL_EJR AS (SELECT SIG.itemgroup_int_id,
   CAL0.cy_month,
   CURR0.client_id,
   SUM(EJR.val_rtl_net_ejr_asis + EJR.val_return_net_ejr_asis) AS val_net_ejr
  FROM ldl_p_lew_mart_lead_ac.v_agg_wh_org_day_item_ejr_asis AS EJR
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_currency AS CURR0 ON EJR.client_id = CURR0.client_id AND EJR.currency_iso_cd =
      CURR0.currency_iso_cd AND CURR0.curr_tot_id = 0
   INNER JOIN ldl_p_lew_mart_lead_ac.v_itm_item AS ITM ON EJR.client_id = ITM.client_id AND EJR.item_id = ITM.item_id
    AND CURR0.client_id = ITM.client_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_subitemgroup AS SIG ON ITM.subitemgroup_id = SIG.subitemgroup_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday AS CAL0 ON EJR.dat_formdate = CAL0.dat_calendar
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead AS R_CL ON CURR0.client_id = R_CL.client_id
  WHERE EJR.aspect_id = 2
   AND CAL0.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
   AND R_CL.dashboard_relevant_fg = 1
  GROUP BY SIG.itemgroup_int_id,
   CAL0.cy_month,
   CURR0.client_id), BNL_SWITCH AS (SELECT CAL1.cy_month,
   WH0.client_id,
   MIN(CASE
     WHEN WH_DAY_PCH.dwh_cal_dt >= (SELECT MIN(dat_calendar)
       FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday
       WHERE byr = (SELECT byr
          FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday
          WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
     THEN 1
     ELSE 0
     END) AS bnl_switch
  FROM ldl_p_lew_mart_lead_ac.v_agg_wh_day_pch AS WH_DAY_PCH
   INNER JOIN ldl_p_lew_mart_msi_ac.v_org_wh_merge AS WH0 ON WH_DAY_PCH.aspect_id = WH0.aspect_id AND WH_DAY_PCH.client_id
       = WH0.client_id AND WH_DAY_PCH.wh_id = WH0.wh_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_currency AS CURR1 ON WH_DAY_PCH.client_id = CURR1.client_id AND WH_DAY_PCH.currency_iso_cd
       = CURR1.currency_iso_cd AND CURR1.curr_tot_id = 0
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday AS CAL1 ON WH_DAY_PCH.dwh_cal_dt = CAL1.dat_calendar
  WHERE WH0.aspect_id = 2
   AND CAL1.cy_month IN (SELECT DISTINCT cy_month
     FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday
     WHERE byr = (SELECT byr
        FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday
        WHERE dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)))
   AND WH0.dashboard_relevant_fg = 1
  GROUP BY CAL1.cy_month,
   WH0.client_id) (SELECT R_CL0.client_id,
   R_CL0.country_iso_cd AS client_desc,
   CAL_MONTH_DESC.byr AS fiscyear,
   CAL_MONTH_DESC.cy_month AS fiscper,
   ITEMGROUP_INT.itemgroup_int_id AS wgi,
   ROUND(MAX(COALESCE(item_pricechange.perm_price_change, 0)), 3) AS perm_price_change_eur,
   ROUND(MAX(IF(val_ejr.val_net_ejr * 100 = 0, 0, SAFE_DIVIDE(COALESCE(item_pricechange.perm_price_change, 0), val_ejr.val_net_ejr
         * 100))), 3) AS perm_price_change_perc,
   ROUND(MAX(COALESCE(item_pricechange.remain_price_change, 0)), 3) AS remain_price_change_eur,
   ROUND(MAX(IF(val_ejr.val_net_ejr * 100 = 0, 0, SAFE_DIVIDE(COALESCE(item_pricechange.remain_price_change, 0), val_ejr
        .val_net_ejr * 100))), 3) AS remain_price_change_perc,
   ROUND(MAX(COALESCE(item_pricechange.adver_price_change, 0)), 3) AS adver_price_change_eur,
   ROUND(MAX(IF(val_ejr.val_net_ejr * 100 = 0, 0, SAFE_DIVIDE(COALESCE(item_pricechange.adver_price_change, 0), val_ejr
        .val_net_ejr * 100))), 3) AS adver_price_change_perc
  FROM ITEM_PRICECHANGE AS item_pricechange
   FULL JOIN VAL_EJR AS val_ejr ON item_pricechange.client_id = val_ejr.client_id AND item_pricechange.cy_month =
      val_ejr.cy_month AND item_pricechange.itemgroup_int_id = val_ejr.itemgroup_int_id
   LEFT JOIN BNL_SWITCH AS bnl_switch0 ON COALESCE(item_pricechange.client_id, val_ejr.client_id) = bnl_switch0.client_id
      AND COALESCE(item_pricechange.cy_month, val_ejr.cy_month) = bnl_switch0.cy_month
   INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead AS R_CL0 ON COALESCE(item_pricechange.client_id, val_ejr.client_id
     ) = R_CL0.client_id
   INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_month_desc AS CAL_MONTH_DESC ON COALESCE(item_pricechange.cy_month, val_ejr.cy_month
     ) = CAL_MONTH_DESC.cy_month
   INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_itemgroup_int AS ITEMGROUP_INT ON COALESCE(item_pricechange.itemgroup_int_id,
     val_ejr.itemgroup_int_id) = ITEMGROUP_INT.itemgroup_int_id
  GROUP BY wgi,
   fiscper,
   fiscyear,
   R_CL0.client_id,
   client_desc);