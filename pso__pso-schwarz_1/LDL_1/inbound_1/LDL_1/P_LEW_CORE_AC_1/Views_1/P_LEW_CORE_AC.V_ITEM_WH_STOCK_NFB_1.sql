CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_ITEM_WH_STOCK_NFB_1
(
    client_id
    , loc_sid
    , item_sid
    , active_from_dt
    , active_to_dt
    , stock_change_seq
    , nfb_type_id
    , delta_case_qty
    , calc_stock_case_qty
    , retail_price
    , retail_net_price
    , vat_total_val
    , modification_dt
    , delta_day_dt
    , deleted_fg
    , dwh_load_id
    , dwh_created
    , dwh_updated
) AS
SELECT
    client_id
    , loc_sid
    , item_sid
    , active_from_dt
    , active_to_dt
    , stock_change_seq
    , nfb_type_id
    , delta_case_qty
    , calc_stock_case_qty
    , retail_price
    , retail_net_price
    , vat_total_val
    , modification_dt
    , delta_day_dt
    , deleted_fg
    , dwh_load_id
    , dwh_created
    , dwh_updated
FROM p_lew_core.t_item_wh_stock_nfb_1
;
