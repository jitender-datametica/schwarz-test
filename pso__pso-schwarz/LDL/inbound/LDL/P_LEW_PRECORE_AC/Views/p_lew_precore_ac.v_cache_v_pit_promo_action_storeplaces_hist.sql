CREATE OR REPLACE VIEW p_lew_precore_ac.v_cache_v_pit_promo_action_storeplaces_hist
(
      client_id
    , pvpas_srcinst_id
    , pvpas_srcinst_code
    , pvpas_pvpac_id
    , pvpas_strplm_id
    , pvpas_strplm_type
    , pvpas_strplm_short_description
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
pvpas_srcinst_id,
pvpas_srcinst_code,
pvpas_pvpac_id,
pvpas_strplm_id,
pvpas_strplm_type,
pvpas_strplm_short_description,
deleted_fg,
dwh_valid_from,
dwh_valid_to,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_precore.t_cache_v_pit_promo_action_storeplaces_hist
;




