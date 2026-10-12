CREATE OR REPLACE VIEW smp_production_data_shared_ldl.p_lew_core_t_item_familygroup_1 (client_id, item_fam_grp_sid,
src_node, src_familygrp_cd, src_familygrp_id, item_fam_grp_name, dwh_load_id, dwh_created, dwh_updated) AS SELECT
 client_id,
 item_fam_grp_sid,
 src_node,
 src_familygrp_cd,
 src_familygrp_id,
 item_fam_grp_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_familygroup_1;