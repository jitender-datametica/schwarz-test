CREATE OR REPLACE VIEW smp_production_data_shared_ldl.p_lew_core_t_subitemgroup (client_id, sub_item_grp_sid, src_node,
src_subitemgrp_cd, src_subitemgrp_id, sub_item_grp_name, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 sub_item_grp_sid,
 src_node,
 src_subitemgrp_cd,
 src_subitemgrp_id,
 sub_item_grp_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_subitemgroup;