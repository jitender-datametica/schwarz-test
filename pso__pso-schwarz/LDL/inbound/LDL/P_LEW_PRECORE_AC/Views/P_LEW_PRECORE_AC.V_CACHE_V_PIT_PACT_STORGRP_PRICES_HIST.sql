CREATE OR REPLACE VIEW P_LEW_PRECORE_AC.V_CACHE_V_PIT_PACT_STORGRP_PRICES_HIST
(
    client_id
  , pvpgp_srcinst_id
  , pvpgp_srcinst_code
  , pvpgp_pvpac_id
  , pvpgp_salestype_value
  , pvpgp_no
  , pvpgp_valid_from
  , pvpgp_valid_to
  , pvpgp_proplan_id
  , pvpgp_storgrp_id
  , pvpgp_price_action_curry_code
  , pvpgp_selling_price_action
  , pvpgp_selling_price_comment
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
  pvpgp_srcinst_id,
  pvpgp_srcinst_code,
  pvpgp_pvpac_id,
  pvpgp_salestype_value,
  pvpgp_no,
  pvpgp_valid_from,
  pvpgp_valid_to,
  pvpgp_proplan_id,
  pvpgp_storgrp_id,
  pvpgp_price_action_curry_code,
  pvpgp_selling_price_action,
  pvpgp_selling_price_comment,
  deleted_fg,
  dwh_valid_from,
  dwh_valid_to,
  dwh_load_id,
  dwh_created,
  dwh_updated
FROM p_lew_precore.t_cache_v_pit_pact_storgrp_prices_hist
;