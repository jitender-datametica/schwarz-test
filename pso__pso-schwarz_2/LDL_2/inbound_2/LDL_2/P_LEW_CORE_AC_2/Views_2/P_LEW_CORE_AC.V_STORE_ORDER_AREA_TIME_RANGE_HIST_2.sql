CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_STORE_ORDER_AREA_TIME_RANGE_HIST_2
(
    client_id
    , loc_sid_store
    , order_area_sid
    , loc_sid_wh
    , wh_order_time_range_sid
    , deleted_fg
    , dwh_valid_from
    , dwh_valid_to
    , dwh_load_id
    , dwh_created
    , dwh_updated
) AS
SELECT
    client_id
    , loc_sid_store
    , order_area_sid
    , loc_sid_wh
    , wh_order_time_range_sid
    , deleted_fg
    , dwh_valid_from
    , dwh_valid_to
    , dwh_load_id
    , dwh_created
    , dwh_updated
FROM p_lew_core.t_store_order_area_time_range_hist_2 ;