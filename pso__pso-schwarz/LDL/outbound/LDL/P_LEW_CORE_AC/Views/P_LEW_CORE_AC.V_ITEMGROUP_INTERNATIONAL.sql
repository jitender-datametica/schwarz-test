CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_itemgroup_international (client_id, item_grp_int_sid, src_node,
src_itemgrp_int_cd, src_itemgrp_int_id, item_grp_int_name, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 item_grp_int_sid,
 src_node,
 src_itemgrp_int_cd,
 src_itemgrp_int_id,
 item_grp_int_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_itemgroup_international;