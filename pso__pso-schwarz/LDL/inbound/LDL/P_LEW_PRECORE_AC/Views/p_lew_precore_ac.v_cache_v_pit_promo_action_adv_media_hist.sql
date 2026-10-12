CREATE OR REPLACE VIEW p_lew_precore_ac.v_cache_v_pit_promo_action_adv_media_hist
(
      client_id
    , pvpam_srcinst_id
    , pvpam_srcinst_code
    , pvpam_pvpac_id
    , pvpam_advmed_id
    , pvpam_advmed_type
    , pvpam_advmed_short_description
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
pvpam_srcinst_id,
pvpam_srcinst_code,
pvpam_pvpac_id,
pvpam_advmed_id,
pvpam_advmed_type,
pvpam_advmed_short_description,
deleted_fg,
dwh_valid_from,
dwh_valid_to,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_precore.t_cache_v_pit_promo_action_adv_media_hist
;



