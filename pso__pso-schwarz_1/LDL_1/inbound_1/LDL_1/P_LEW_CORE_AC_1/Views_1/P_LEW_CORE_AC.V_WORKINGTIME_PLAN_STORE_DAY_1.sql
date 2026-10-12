CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_WORKINGTIME_PLAN_STORE_DAY_1
(
    client_id
    , loc_sid_store
    , cal_dt
    , turnover_net_val
    , sales_piece_qty
    , turnover_per_hour_net_val
    , hours_total_cnt
    , hours_working_cnt
    , hours_inventory_cnt
    , hours_training_cnt
    , hours_misc_cnt
    , plan_update_tmsp
    , source_system
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
SELECT
    client_id
    , loc_sid_store
    , cal_dt
    , turnover_net_val
    , sales_piece_qty
    , turnover_per_hour_net_val
    , hours_total_cnt
    , hours_working_cnt
    , hours_inventory_cnt
    , hours_training_cnt
    , hours_misc_cnt
    , plan_update_tmsp
    , source_system
    , dwh_load_id
    , dwh_created
    , dwh_updated
FROM p_lew_core.t_workingtime_plan_store_day_1
;