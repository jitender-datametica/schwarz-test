CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics.v_subitemgroup_1 (client_id, sub_item_grp_sid, src_node, src_subitemgrp_cd
, src_subitemgrp_id, sub_item_grp_name, dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_core_ac.v_subitemgroup_1;