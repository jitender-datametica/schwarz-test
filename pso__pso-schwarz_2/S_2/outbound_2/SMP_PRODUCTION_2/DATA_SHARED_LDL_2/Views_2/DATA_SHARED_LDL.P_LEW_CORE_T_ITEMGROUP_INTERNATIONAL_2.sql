CREATE OR REPLACE VIEW smp_production_data_shared_ldl.p_lew_core_t_itemgroup_international_2 (client_id, item_grp_int_sid
, src_node, src_itemgrp_int_cd, src_itemgrp_int_id, item_grp_int_name, dwh_load_id, dwh_created, dwh_updated) AS SELECT
 client_id,
 item_grp_int_sid,
 src_node,
 src_itemgrp_int_cd,
 src_itemgrp_int_id,
 item_grp_int_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_itemgroup_international_2;