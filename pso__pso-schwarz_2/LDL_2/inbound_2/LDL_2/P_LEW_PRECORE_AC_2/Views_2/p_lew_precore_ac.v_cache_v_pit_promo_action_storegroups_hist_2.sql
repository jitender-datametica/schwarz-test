CREATE OR REPLACE VIEW p_lew_precore_ac.v_cache_v_pit_promo_action_storegroups_hist_2
(
    client_id
    , pvpag_srcinst_id
    , pvpag_srcinst_code
    , pvpag_pvpac_id
    , pvpag_storgrp_id
    , pvpag_storgrp_code
    , pvpag_storgrp_name
    , pvpag_storgrp_type
    , pvpag_warehs_id
    , pvpag_warehs_no
    , pvpag_lsttype_value
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
pvpag_srcinst_id,
pvpag_srcinst_code,
pvpag_pvpac_id,
pvpag_storgrp_id,
pvpag_storgrp_code,
pvpag_storgrp_name,
pvpag_storgrp_type,
pvpag_warehs_id,
pvpag_warehs_no,
pvpag_lsttype_value,
deleted_fg,
dwh_valid_from,
dwh_valid_to,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_precore.t_cache_v_pit_promo_action_storegroups_hist_2
;




