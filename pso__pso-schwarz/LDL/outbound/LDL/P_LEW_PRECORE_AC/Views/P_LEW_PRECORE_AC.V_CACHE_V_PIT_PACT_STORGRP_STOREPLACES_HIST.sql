CREATE OR REPLACE VIEW ldl_p_lew_precore_ac.v_cache_v_pit_pact_storgrp_storeplaces_hist (client_id, pvpgs_srcinst_id,
pvpgs_srcinst_code, pvpgs_pvpac_id, pvpgs_strplm_id, pvpgs_proplan_id, pvpgs_storgrp_id, pvpgs_strplm_type,
pvpgs_strplm_short_description, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS
SELECT client_id,
 pvpgs_srcinst_id,
 pvpgs_srcinst_code,
 pvpgs_pvpac_id,
 pvpgs_strplm_id,
 pvpgs_proplan_id,
 pvpgs_storgrp_id,
 pvpgs_strplm_type,
 pvpgs_strplm_short_description,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_precore.t_cache_v_pit_pact_storgrp_storeplaces_hist;