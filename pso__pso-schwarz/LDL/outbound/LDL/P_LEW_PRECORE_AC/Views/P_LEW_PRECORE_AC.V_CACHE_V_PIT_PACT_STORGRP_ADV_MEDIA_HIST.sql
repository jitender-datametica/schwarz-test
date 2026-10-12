CREATE OR REPLACE VIEW ldl_p_lew_precore_ac.v_cache_v_pit_pact_storgrp_adv_media_hist (client_id, pvpgm_srcinst_id,
pvpgm_srcinst_code, pvpgm_pvpac_id, pvpgm_advmed_id, pvpgm_proplan_id, pvpgm_storgrp_id, pvpgm_advmed_type,
pvpgm_advmed_short_description, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS
SELECT client_id,
 pvpgm_srcinst_id,
 pvpgm_srcinst_code,
 pvpgm_pvpac_id,
 pvpgm_advmed_id,
 pvpgm_proplan_id,
 pvpgm_storgrp_id,
 pvpgm_advmed_type,
 pvpgm_advmed_short_description,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_precore.t_cache_v_pit_pact_storgrp_adv_media_hist;