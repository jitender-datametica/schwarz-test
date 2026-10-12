CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_WAREHOUSE_ORDER_TIME_RANGE_1
(
    client_id
    , wh_order_time_range_sid
    , src_orig_wh_nr
    , src_range_zone_id
    , loc_sid_wh
    , order_time_range_name
    , order_time_plan_id
    , order_time_from_tm
    , order_time_to_tm
    , dwh_load_id
    , dwh_created
    , dwh_updated
) AS
SELECT
    client_id
    , wh_order_time_range_sid
    , src_orig_wh_nr
    , src_range_zone_id
    , loc_sid_wh
    , order_time_range_name
    , order_time_plan_id
    , order_time_from_tm
    , order_time_to_tm
    , dwh_load_id
    , dwh_created
    , dwh_updated
FROM p_lew_core.t_warehouse_order_time_range_1 ;