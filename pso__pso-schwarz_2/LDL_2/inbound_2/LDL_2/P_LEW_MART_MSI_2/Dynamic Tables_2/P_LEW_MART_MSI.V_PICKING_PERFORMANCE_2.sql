
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_PICKING_PERFORMANCE_2

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT
   a.client_id,
   wh.src_wh_id AS wh_id,
   a.pick_list_id AS picking_receipt_nr,
   a.performance_type_cd,
   a.performance_cd,
   a.pick_area_id AS picking_area_nr_pp,
   a.dwh_cal_dt    AS dat_performance,
   a.performance_tmsp AS timestamp_performance,
   a.transport_method_cd AS means_of_transport_id,
   a.performance_grp_cd    AS performance_grp,
   a.target_time_cnt AS qty_sum_target_time,
   a.working_time_cnt AS qty_sum_working_time,
   a.lead_time_cnt AS qty_sum_lead_time,
   a.lag_time_cnt AS qty_sum_lag_time,
   a.extra_time_cnt AS qty_sum_extra_time,
   a.break_time_cnt    AS qty_sum_break_time,
   a.days_cnt AS cnt_days,
   a.hours_cnt AS cnt_hours,
   a.staff_cnt AS cnt_staff,
   a.order_cnt AS cnt_order,
   a.target_pick_te_qty    AS cnt_te,
   a.position_total_cnt AS cnt_pick_position,
   a.act_pick_case_qty AS cnt_pick_case,
   a.total_weight_gross_qty    AS qty_sum_gross_weight,
   a.total_weight_net_qty AS qty_sum_net_weight,
   a.break_cnt AS qty_sum_break,
   a.act_pick_te_qty AS cnt_pick_te,
   a.target_pick_case_qty AS cnt_target_case,
   a.act_handhe_cnt    AS cnt_pick_handhe,
   a.act_entry_thm_cnt AS cnt_pick_entry_thm,
   a.act_orig_thm_cnt AS cnt_pick_orig_thm,
   a.dwh_load_id AS load_id
   FROM p_lew_core_ac.v_pick_performance_2 AS a
   INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh
   ON wh.client_id = a.client_id
   AND wh.loc_sid_wh =  a.loc_sid
   AND wh.dwh_actual_fg = 1
;
