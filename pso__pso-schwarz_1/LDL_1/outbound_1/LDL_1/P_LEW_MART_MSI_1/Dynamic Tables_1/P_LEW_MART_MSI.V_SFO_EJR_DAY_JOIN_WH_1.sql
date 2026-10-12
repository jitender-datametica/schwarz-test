CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_sfo_ejr_day_join_wh_1 AS
SELECT ejr.client_id,
 ejr.wh_id,
 ejr.dat_calendar,
 ejr.currency_iso_cd,
 sfo.abswh,
 sfo.bnl,
 ejr.val_retail_asis,
 ejr.val_retail_net_asis
FROM (SELECT sfo.client_id,
   WH.src_wh_id AS wh_id,
   sfo.dat_formdate,
   sfo.currency_iso_cd,
   SUM(CASE
     WHEN sfo.sfotype_id IN (181, 182, 191, 192)
     THEN sfo.val_rtl_rcptline_sfo_asis
     ELSE NULL
     END) AS abswh,
   SUM(CASE
     WHEN sfo.sfotype_id IN (131, 141) AND ROUND(CAST(SUB.src_subitemgrp_cd AS BIGNUMERIC), 0) BETWEEN 100 AND 199
     THEN sfo.qty_total_sfo_asis * (sfo.price_str_sfo_asis - sfo.price_wh_sfo_asis)
     ELSE NULL
     END) AS bnl
  FROM (SELECT AGG.client_id,
     AGG.st_loc_sid,
     AGG.item_sid,
     AGG.dat_formdate,
     AGG.sfotype_id,
      AGG.val_rtl_rl_sfo / CRY.rate_currency_exchange AS val_rtl_rcptline_sfo_asis,
     AGG.qty_total_sfo AS qty_total_sfo_asis,
     CRY.currency_iso_cd,
      ABS(CAST(AGG.val_total_str_sfo AS BIGNUMERIC) / CASE
         WHEN AGG.qty_total_sfo = 0
         THEN NULL
         ELSE AGG.qty_total_sfo
         END) / CRY.rate_currency_exchange AS price_str_sfo_asis,
      ABS(CAST(AGG.val_total_wh_sfo AS BIGNUMERIC) / CASE
         WHEN AGG.qty_total_sfo = 0
         THEN NULL
         ELSE AGG.qty_total_sfo
         END) / CRY.rate_currency_exchange AS price_wh_sfo_asis
    FROM ldl_p_lew_core_ac.v_wawi_agg_store_day_item_sfo_1 AS AGG
     INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON AGG.client_id = CRY.client_id AND
       CURRENT_DATE BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
    WHERE AGG.sfotype_id IN (181, 182, 191, 192, 131, 141)) AS sfo
   INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_skey_act_1 AS OS ON sfo.client_id = OS.client_id AND sfo.st_loc_sid = OS
     .st_loc_sid -- MSI Layer Store_id entspricht loc_sid

   INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON OS.client_id = WH.client_id AND OS.wh_loc_sid = WH.loc_sid_wh AND WH
     .dwh_actual_fg = 1
   INNER JOIN ldl_p_lew_bil_ac.v_item_1 AS ITM ON sfo.client_id = ITM.client_id AND sfo.item_sid = ITM.item_sid AND ITM.dwh_actual_fg
      = 1
   INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_1 AS SUB ON ITM.client_id = SUB.client_id AND ITM.sub_item_grp_sid_asis =
     SUB.sub_item_grp_sid
   INNER JOIN (SELECT CALDAY.dat_calendar,
     CALDAY.cy_week
    FROM ldl_p_lew_mart_msi.v_cal_calendarday_1 AS CALDAY
     INNER JOIN ldl_p_lew_mart_msi.v_cal_busyear_1 AS BYR ON CALDAY.byr = BYR.byr
    WHERE BYR.cy_by_sequence BETWEEN - 3 AND 0) AS a13 ON sfo.dat_formdate = a13.dat_calendar
  GROUP BY sfo.client_id,
   wh_id,
   sfo.dat_formdate,
   sfo.currency_iso_cd) AS sfo
 RIGHT JOIN (SELECT A12.client_id,
   OS0.wh_id,
   a13.dat_calendar,
   CRY0.currency_iso_cd,
   SUM(UMS.sales_gross_val / CRY0.rate_currency_exchange) AS val_retail_asis,
   SUM(UMS.sales_net_val / CRY0.rate_currency_exchange) AS val_retail_net_asis
  FROM ldl_p_lew_mart_msi.v_org_store_1 AS A12
   INNER JOIN ldl_p_lew_mart_msi.v_org_store_skey_1 AS OS0 ON A12.client_id = OS0.client_id AND A12.store_id = OS0.store_id
     
   LEFT JOIN ldl_p_lew_mart_msi.v_cal_calendarday_1 AS CAL ON A12.dat_calc_end_py = CAL.dat_calendar
   INNER JOIN ldl_p_lew_mart_msi.v_org_all_store_reloc_1 AS A14 ON A12.client_id = A14.client_id AND A12.store_id = A14.store_id
     
   INNER JOIN (SELECT CALDAY0.dat_calendar,
     CALDAY0.cy_week
    FROM ldl_p_lew_mart_msi.v_cal_calendarday_1 AS CALDAY0
     INNER JOIN ldl_p_lew_mart_msi.v_cal_busyear_1 AS BYR0 ON CALDAY0.byr = BYR0.byr
    WHERE BYR0.cy_by_sequence BETWEEN - 3 AND 0
     AND CALDAY0.cy_day_sequence <= - 0) AS a13 ON TRUE
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY0 ON A12.client_id = CRY0.client_id AND
     CURRENT_DATE BETWEEN CRY0.dat_rec_start AND CRY0.dat_rec_end
   LEFT JOIN ldl_p_lew_bil_ac.v_agg_pos_txj_wawi_store_day_1 AS UMS ON A12.client_id = UMS.client_id AND A12.store_id =
      UMS.loc_sid AND a13.dat_calendar = UMS.dwh_cal_dt
  GROUP BY A12.client_id,
   OS0.wh_id,
   a13.dat_calendar,
   CRY0.currency_iso_cd) AS ejr ON sfo.client_id = ejr.client_id AND sfo.wh_id = ejr.wh_id AND sfo.dat_formdate = ejr.dat_calendar
     AND sfo.currency_iso_cd = ejr.currency_iso_cd;