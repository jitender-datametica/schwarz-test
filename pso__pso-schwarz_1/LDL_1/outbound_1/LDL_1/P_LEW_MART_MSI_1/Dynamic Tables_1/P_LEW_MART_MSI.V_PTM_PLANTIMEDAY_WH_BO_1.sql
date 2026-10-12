CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_ptm_plantimeday_wh_bo_1 AS
SELECT C.cy_week - C.cy * 100 AS cal_week,
 PTM.client_id,
 PTM.dwh_created AS dat_creation,
 PTM.dwh_created AS dat_dayend,
 PTM.plan_update_tmsp AS dat_last_update,
 PTM.cal_dt AS dat_plantime,
 PTM.dwh_load_id AS load_id,
 NULL AS plantimeday_desc,
 0 AS release_fg,
 PTM.loc_sid_store AS store_id,
 0 AS val_holidays,
 PTM.hours_total_cnt AS val_hours,
 PTM.hours_inventory_cnt AS val_inventory,
 PTM.turnover_per_hour_net_val AS val_performance,
 PTM.hours_training_cnt AS val_training,
 PTM.turnover_net_val AS val_turnover,
 0 AS val_workingdays,
 W.loc_sid_wh AS wh_id
FROM ldl_p_lew_core_ac.v_workingtime_plan_store_day_1 AS PTM
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS C ON PTM.cal_dt = C.cal_dt
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_1 AS W ON PTM.client_id = W.client_id AND PTM.loc_sid_store = W.loc_sid_store;