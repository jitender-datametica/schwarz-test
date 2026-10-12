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

CREATE OR REPLACE VIEW P_LEW_BIL.V_PTM_PLAN_TIME_STORE_DAY 
AS
SELECT  
  pm.client_id
, pm.loc_sid_store                                 AS store_id
, pm.cal_dt                                        AS dat_plantime
, c.cy_week - (c.cy * 100)                         AS cal_week
, CASE WHEN pm.client_id <> 12 THEN COALESCE((pm.sales_piece_qty * pp.avg_price_pep), (pm.turnover_net_val / cry.rate_currency_exchange))
     ELSE pm.turnover_net_val / cry.rate_currency_exchange * pp.avg_price_pep
  END                                              AS val_turnover
, pp.sales_pieces_pep                              AS val_sales_pieces_pep
, pp.avg_price_pep                                 AS val_avg_price_pep
, pm.hours_total_cnt                               AS val_hours
, pm.turnover_per_hour_net_val                     AS val_performance
, pm.hours_inventory_cnt                           AS val_inventory
, pm.hours_training_cnt                            AS val_training
, pm.hours_misc_cnt                                AS val_misc
, pm.hours_working_cnt                             AS val_working
, 0                                                AS val_workingdays
, 0                                                AS val_holidays
, 0                                                AS release_fg
, ''                                               AS plantimeday_desc
, pm.plan_update_tmsp                              AS dat_last_update
, pm.dwh_created                                   AS dat_creation
, pm.dwh_created                                   AS dat_dayend
, cry.currency_iso_cd    
FROM p_lew_core_ac.v_workingtime_plan_store_day pm          

INNER JOIN p_lew_core_ac.v_cal_calendarday c              
ON pm.cal_dt = c.cal_dt               

INNER  JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS cry    
ON   pm.client_id = cry.client_id               
AND  CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end             

INNER JOIN P_LEW_BIL.v_agg_store_day_piece_perf_plan_pep pp
ON pp.client_id = pm.client_id
AND pp.loc_sid_store = pm.loc_sid_store
AND pp.dwh_cal_dt = pm.cal_dt
AND pp.currency_iso_cd = cry.currency_iso_cd
;
