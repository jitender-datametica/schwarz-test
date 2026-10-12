CREATE OR REPLACE VIEW p_lew_precore_ac.v_cache_v_pit_promotion_action_prices_hist_2
(
      client_id
    , pvpap_srcinst_id
    , pvpap_srcinst_code
    , pvpap_pvpac_id
    , pvpap_salestype_value
    , pvpap_no
    , pvpap_valid_from
    , pvpap_valid_to
    , pvpap_price_action_curry_code
    , pvpap_selling_price_action
    , pvpap_selling_price_comment
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
pvpap_srcinst_id,
pvpap_srcinst_code,
pvpap_pvpac_id,
pvpap_salestype_value,
pvpap_no,
pvpap_valid_from,
pvpap_valid_to,
pvpap_price_action_curry_code,
pvpap_selling_price_action,
pvpap_selling_price_comment,
deleted_fg,
dwh_valid_from,
dwh_valid_to,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_precore.t_cache_v_pit_promotion_action_prices_hist_2
;




