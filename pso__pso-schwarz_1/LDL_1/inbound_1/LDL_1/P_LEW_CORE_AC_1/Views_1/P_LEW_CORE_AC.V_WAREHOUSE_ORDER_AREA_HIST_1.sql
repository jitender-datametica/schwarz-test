CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_WAREHOUSE_ORDER_AREA_HIST_1
(
    client_id
    , loc_sid_wh
    , order_area_sid
    , wh_order_area_name
    , deleted_fg
    , dwh_valid_from
    , dwh_valid_to
    , dwh_load_id
    , dwh_created
    , dwh_updated
) AS
SELECT
    client_id
    , loc_sid_wh
    , order_area_sid
    , wh_order_area_name
    , deleted_fg
    , dwh_valid_from
    , dwh_valid_to
    , dwh_load_id
    , dwh_created
    , dwh_updated
FROM p_lew_core.t_warehouse_order_area_hist_1 ;