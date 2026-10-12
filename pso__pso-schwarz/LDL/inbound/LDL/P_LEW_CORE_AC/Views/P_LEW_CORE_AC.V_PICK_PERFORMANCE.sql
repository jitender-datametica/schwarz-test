CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_PICK_PERFORMANCE
(
      client_id
    , loc_sid
    , pick_list_id
    , performance_tmsp
    , performance_type_cd
    , performance_grp_cd
    , performance_cd
    , pick_area_id
    , transport_method_cd
    , target_time_cnt
    , working_time_cnt
    , lead_time_cnt
    , lag_time_cnt
    , break_time_cnt
    , extra_time_cnt
    , days_cnt
    , hours_cnt
    , staff_cnt
    , break_cnt
    , order_cnt
    , position_total_cnt
    , target_pick_te_qty
    , act_pick_te_qty
    , target_pick_case_qty
    , act_pick_case_qty
    , total_weight_gross_qty
    , total_weight_net_qty
    , act_handhe_cnt
    , act_entry_thm_cnt
    , act_orig_thm_cnt
    , dwh_cal_dt
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
   SELECT
       client_id,
   loc_sid,
   pick_list_id,
   performance_tmsp,
   performance_type_cd,
   performance_grp_cd,
   performance_cd,
   pick_area_id,
   transport_method_cd,
   target_time_cnt,
   working_time_cnt,
   lead_time_cnt,
   lag_time_cnt,
   break_time_cnt,
   extra_time_cnt,
   days_cnt,
   hours_cnt,
   staff_cnt,
   break_cnt,
   order_cnt,
   position_total_cnt,
   target_pick_te_qty,
   act_pick_te_qty,
   target_pick_case_qty,
   act_pick_case_qty,
   total_weight_gross_qty,
   total_weight_net_qty,
   act_handhe_cnt,
   act_entry_thm_cnt,
   act_orig_thm_cnt,
   dwh_cal_dt,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core.t_pick_performance
;