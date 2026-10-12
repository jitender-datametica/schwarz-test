/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_MAT_BW_RETAIL_EJR_CUM_BY_2
#----------------------------------------------------------------------------
# History:
#   1.0      14.11.2023      Ulrich Ross              Init
#                                                     User Story 532005                                                                                  
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_bw_retail_ejr_cum_by_2 (client_id, wh_id, cy_month, aspect_id,
item_familygroup_id, subitemgroup_id, subitemgroup_id0, buying_list_type_id, curr_tot_id, currency_iso_cd,
val_ejr_cum_by) AS -- M1401
 SELECT EJR.client_id,
 EJR.wh_id,
 CAL.cy_month,
 EJR.aspect_id,
 FG.family_cd AS item_familygroup_id,
 ITM.subitemgroup_id,
 FG.subitemgroup_id AS subitemgroup_id0,
  CASE
  WHEN ILT.buying_list_type_id IS NULL
  THEN CAST(- 1 AS BIGNUMERIC)
  ELSE ILT.buying_list_type_id
  END AS buying_list_type_id,
 CUR.curr_tot_id,
 CUR.currency_iso_cd,
 SUM(EJR.val_rtl_net_ejr_asis + EJR.val_return_net_ejr_asis) AS val_ejr_cum_by
FROM ldl_p_lew_mart_lead_ac.v_agg_wh_org_day_item_ejr_asis_2 AS EJR
 INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_busyear_cum_2 AS BCUM ON EJR.dat_formdate = BCUM.dat_byr_cum
 INNER JOIN ldl_p_lew_mart_lead_ac.v_itm_item_list_type_hist_2 AS ILT ON EJR.client_id = ILT.client_id AND EJR.dat_formdate
      <= ILT.dat_rec_end AND EJR.dat_formdate >= ILT.dat_rec_start AND EJR.item_id = ILT.item_id
 INNER JOIN ldl_p_lew_mart_lead_ac.v_itm_item_2 AS ITM ON EJR.client_id = ITM.client_id AND EJR.item_id = ITM.item_id
 INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_familygroup_2 AS FG ON ITM.client_id = FG.client_id AND ITM.item_familygroup_id =
   FG.item_familygroup_id
 INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_currency_2 AS CUR ON EJR.client_id = CUR.client_id AND EJR.currency_iso_cd = CUR.currency_iso_cd
   
 INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_calendarday_2 AS CAL ON BCUM.dat_calendar = CAL.dat_calendar
 INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_client_lead_2 AS CL ON ITM.client_id = CL.client_id
WHERE CAL.cy_day_sequence <= 0
 AND (CUR.curr_tot_id = 0 AND CUR.currency_iso_cd = 'EUR' OR CUR.curr_tot_id = 3 AND CUR.currency_iso_cd = 'BGN' OR CUR
              .curr_tot_id = 4 AND CUR.currency_iso_cd = 'CHF' OR CUR.curr_tot_id = 6 AND CUR.currency_iso_cd = 'CZK' OR
            CUR.curr_tot_id = 8 AND CUR.currency_iso_cd = 'DKK' OR CUR.curr_tot_id = 16 AND CUR.currency_iso_cd = 'HUF'
        OR CUR.curr_tot_id = 24 AND CUR.currency_iso_cd = 'PLN' OR CUR.curr_tot_id = 26 AND CUR.currency_iso_cd = 'RON'
      OR CUR.curr_tot_id = 27 AND CUR.currency_iso_cd = 'SEK' OR CUR.curr_tot_id = 33 AND CUR.currency_iso_cd = 'USD' OR
      CUR.curr_tot_id = 34 AND CUR.currency_iso_cd = 'RSD' OR CUR.curr_tot_id = 40 AND CUR.currency_iso_cd = 'GBP')
 AND EJR.aspect_id = 1
 AND CAL.dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
 AND BCUM.dat_calendar = DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY)
 AND CL.dashboard_relevant_fg = 1
GROUP BY CUR.curr_tot_id,
 CUR.currency_iso_cd,
 ITM.subitemgroup_id,
 CAL.cy_month,
 EJR.client_id,
 EJR.aspect_id,
 EJR.wh_id,
 item_familygroup_id,
 subitemgroup_id0,
 buying_list_type_id;