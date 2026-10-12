CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_ptm_ejr_day_join_2 AS
SELECT ejr.client_id,
 ejr.store_id,
 ejr.dat_calendar,
 ejr.currency_iso_cd,
 ptm.working_time_brutto_std,
 ptm.break_std,
 ptm.time_working_netto_std,
 CAST(ejr.val_retail_asis AS NUMERIC) AS val_retail_asis,
 CAST(ejr.val_retail_net_asis AS NUMERIC) AS val_retail_net_asis
FROM (SELECT PTM.client_id,
   PTM.store_id,
   PTM.dat_working,
   SUM(PTM.working_time_brutto_std) AS working_time_brutto_std,
   SUM(PTM.break_std) AS break_std,
   SUM(PTM.time_working_netto_std) AS time_working_netto_std
  FROM ldl_p_lew_mart_msi.v_ptm_working_time_store_2 AS PTM
   INNER JOIN (SELECT CALDAY.cal_dt,
     CALDAY.cy_week
    FROM ldl_p_lew_core_ac.v_cal_calendarday_2 AS CALDAY
     INNER JOIN ldl_p_lew_core_ac.v_cal_busyear_2 AS BYR ON CALDAY.busyear = BYR.busyear
    WHERE BYR.cy_by_seq BETWEEN - 3 AND 0) AS a13 ON PTM.dat_working = a13.cal_dt
  GROUP BY PTM.client_id,
   PTM.store_id,
   PTM.dat_working) AS ptm
 RIGHT JOIN (SELECT OSS.client_id,
   OSS.st_loc_sid AS store_id,
   cal.cal_dt AS dat_calendar,
   CRY.currency_iso_cd,
   agg.val_retail_asis,
   agg.val_retail_net_asis
  FROM ldl_p_lew_core_ac.v_wawi_org_store_skey_act_2 AS OSS
   INNER JOIN (SELECT CAL.cal_dt,
     CAL.cy_week
    FROM ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL
     INNER JOIN ldl_p_lew_core_ac.v_cal_busyear_2 AS BYR0 ON CAL.busyear = BYR0.busyear
    WHERE BYR0.cy_by_seq BETWEEN - 3 AND 0) AS cal ON TRUE
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY ON OSS.client_id = CRY.client_id AND CURRENT_DATE
     BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
   LEFT JOIN (SELECT AGG.client_id,
     AGG.dwh_cal_dt,
     AGG.loc_sid,
      AGG.sales_gross_val / CRY0.rate_currency_exchange AS val_retail_asis,
      AGG.sales_net_val / CRY0.rate_currency_exchange AS val_retail_net_asis,
     CRY0.currency_iso_cd
    FROM ldl_p_lew_bil_ac.v_agg_pos_txj_wawi_store_day_2 AS AGG
     INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY0 ON AGG.client_id = CRY0.client_id AND
       CURRENT_DATE BETWEEN CRY0.dat_rec_start AND CRY0.dat_rec_end) AS agg ON OSS.client_id = agg.client_id AND OSS.st_loc_sid
        = agg.loc_sid AND cal.cal_dt = agg.dwh_cal_dt AND CRY.currency_iso_cd = agg.currency_iso_cd) AS ejr ON ptm.client_id
     = ejr.client_id AND ptm.store_id = ejr.store_id AND ptm.dat_working = ejr.dat_calendar;