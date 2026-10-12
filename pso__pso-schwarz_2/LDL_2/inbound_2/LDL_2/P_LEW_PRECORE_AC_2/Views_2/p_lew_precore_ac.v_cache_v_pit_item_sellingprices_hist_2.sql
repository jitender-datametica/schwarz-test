CREATE OR REPLACE VIEW p_lew_precore_ac.v_cache_v_pit_item_sellingprices_hist_2
(
      client_id
    , pvisp_srcinst_id
    , pvisp_srcinst_code
    , pvisp_pvpit_id
    , pvisp_salestype_value
    , pvisp_no
    , pvisp_selling_price
    , pvisp_selling_price_curry_code
    , deleted_fg
    , dwh_valid_from
    , dwh_valid_to
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
SELECT
client_id,
pvisp_srcinst_id,
pvisp_srcinst_code,
pvisp_pvpit_id,
pvisp_salestype_value,
pvisp_no,
pvisp_selling_price,
pvisp_selling_price_curry_code,
deleted_fg,
dwh_valid_from,
dwh_valid_to,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_precore.t_cache_v_pit_item_sellingprices_hist_2
;




