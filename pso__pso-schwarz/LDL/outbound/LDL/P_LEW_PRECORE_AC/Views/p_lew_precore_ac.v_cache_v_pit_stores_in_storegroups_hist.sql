CREATE OR REPLACE VIEW ldl_p_lew_precore_ac.v_cache_v_pit_stores_in_storegroups_hist (client_id, pvssg_srcinst_id,
pvssg_srcinst_code, pvssg_storgrp_id, pvssg_store_id, pvssg_store_no, pvssg_store_name, pvssg_valid_from, pvssg_valid_to
, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 pvssg_srcinst_id,
 pvssg_srcinst_code,
 pvssg_storgrp_id,
 pvssg_store_id,
 pvssg_store_no,
 pvssg_store_name,
 pvssg_valid_from,
 pvssg_valid_to,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_precore.t_cache_v_pit_stores_in_storegroups_hist;