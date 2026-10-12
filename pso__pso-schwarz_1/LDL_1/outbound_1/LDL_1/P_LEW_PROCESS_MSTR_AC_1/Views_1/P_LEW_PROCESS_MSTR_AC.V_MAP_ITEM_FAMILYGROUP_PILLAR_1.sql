CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_map_item_familygroup_pillar_1 (src_familygrp_cd, item_fam_grp_name,
pillar_id, dwh_valid_from, dwh_valid_to, dwh_actual_fg, dwh_created, dwh_updated) AS SELECT src_familygrp_cd,
 item_fam_grp_name,
 pillar_id,
 dwh_valid_from,
 dwh_valid_to,
 dwh_actual_fg,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_process_mstr.t_map_item_familygroup_pillar_1 AS V;