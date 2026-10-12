CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_mainitemgroup_2 (client_id, main_item_grp_sid, src_mainitemgrp_id,
main_item_grp_name, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 main_item_grp_sid,
 src_mainitemgrp_id,
 main_item_grp_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_mainitemgroup_2;