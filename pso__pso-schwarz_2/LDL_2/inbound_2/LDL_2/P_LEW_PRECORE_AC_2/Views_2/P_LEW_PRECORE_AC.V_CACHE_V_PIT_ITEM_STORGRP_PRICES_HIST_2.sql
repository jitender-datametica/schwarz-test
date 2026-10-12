CREATE OR REPLACE VIEW P_LEW_PRECORE_AC.V_CACHE_V_PIT_ITEM_STORGRP_PRICES_HIST_2
(
    client_id
  , pvigp_srcinst_id
  , pvigp_srcinst_code
  , pvigp_id
  , pvigp_pvpit_id
  , pvigp_salestype_value
  , pvigp_no
  , pvigp_storgrp_id
  , pvigp_selling_price
  , pvigp_selling_price_curry_code
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
  pvigp_srcinst_id,
  pvigp_srcinst_code,
  pvigp_id,
  pvigp_pvpit_id,
  pvigp_salestype_value,
  pvigp_no,
  pvigp_storgrp_id,
  pvigp_selling_price,
  pvigp_selling_price_curry_code,
  deleted_fg,
  dwh_valid_from,
  dwh_valid_to,
  dwh_load_id,
  dwh_created,
  dwh_updated
FROM p_lew_precore.t_cache_v_pit_item_storgrp_prices_hist_2
;