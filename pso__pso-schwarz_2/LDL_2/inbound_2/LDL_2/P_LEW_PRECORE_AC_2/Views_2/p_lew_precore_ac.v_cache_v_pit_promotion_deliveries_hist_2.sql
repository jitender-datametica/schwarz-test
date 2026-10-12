CREATE OR REPLACE VIEW p_lew_precore_ac.v_cache_v_pit_promotion_deliveries_hist_2
(
    client_id
    , pvpdl_srcinst_id
    , pvpdl_srcinst_code
    , pvpdl_id
    , pvpdl_pvpit_id
    , pvpdl_delivery_date_from
    , pvpdl_case_size
    , pvpdl_palett_factor
    , pvpdl_delivery_amount
    , pvpdl_buying_price_curry_code
    , pvpdl_buying_price_net
    , pvpdl_supplier_name
    , pvpdl_supplier_no_int
    , pvpdl_warehs_id
    , pvpdl_negotiated_by
    , deleted_fg
    , dwh_valid_from
    , dwh_valid_to
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
SELECT
 client_id
,pvpdl_srcinst_id
,pvpdl_srcinst_code
,pvpdl_id
,pvpdl_pvpit_id
,pvpdl_delivery_date_from
,pvpdl_case_size
,pvpdl_palett_factor
,pvpdl_delivery_amount
,pvpdl_buying_price_curry_code
,pvpdl_buying_price_net
,pvpdl_supplier_name
,pvpdl_supplier_no_int
,pvpdl_warehs_id
,pvpdl_negotiated_by
,deleted_fg
,dwh_valid_from
,dwh_valid_to
,dwh_load_id
,dwh_created
,dwh_updated
FROM p_lew_precore.t_cache_v_pit_promotion_deliveries_hist_2 ;




