/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.v_ptm_plan_time_store_day
#----------------------------------------------------------------------------
# History:
#  1.0  2022-05-09    Marcin Malec          Created; 
#                                           Logic moved and modified from view P_LEW_MART_MSI.v_ptm_plan_time_store_day - val_turnover adjustment for France and BIL view usage in other objects
#  1.1  2022-08-08    Marcin Malec          Change of sales_pieces_pep logic for Hungary
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_bil.v_ptm_plan_time_store_day AS SELECT PM.client_id,
 PM.loc_sid_store AS store_id,
 PM.cal_dt AS dat_plantime,
  C.cy_week - C.cy * 100 AS cal_week,
  CASE
  WHEN PM.client_id <> 12
  THEN COALESCE(PM.sales_piece_qty * PP.avg_price_pep, PM.turnover_net_val / CRY.rate_currency_exchange)
  ELSE PM.turnover_net_val / CRY.rate_currency_exchange * PP.avg_price_pep
  END AS val_turnover,
 PP.sales_pieces_pep AS val_sales_pieces_pep,
 PP.avg_price_pep AS val_avg_price_pep,
 PM.hours_total_cnt AS val_hours,
 PM.turnover_per_hour_net_val AS val_performance,
 PM.hours_inventory_cnt AS val_inventory,
 PM.hours_training_cnt AS val_training,
 PM.hours_misc_cnt AS val_misc,
 PM.hours_working_cnt AS val_working,
 0 AS val_workingdays,
 0 AS val_holidays,
 0 AS release_fg,
 '' AS plantimeday_desc,
 PM.plan_update_tmsp AS dat_last_update,
 PM.dwh_created AS dat_creation,
 PM.dwh_created AS dat_dayend,
 CRY.currency_iso_cd
FROM ldl_p_lew_core_ac.v_workingtime_plan_store_day AS PM
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS C ON PM.cal_dt = C.cal_dt
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS CRY ON PM.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
 INNER JOIN ldl_p_lew_bil.v_agg_store_day_piece_perf_plan_pep AS PP ON PM.client_id = PP.client_id AND PM.loc_sid_store
     = PP.loc_sid_store AND PM.cal_dt = PP.dwh_cal_dt AND CRY.currency_iso_cd = PP.currency_iso_cd;