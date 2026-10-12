CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_itm_fam_pillar_map_2 (client_id, item_familygroup_id, src_familygrp_cd
, pillar_id) AS SELECT client_id,
 item_familygroup_id,
 src_familygrp_cd,
 pillar_id
FROM ldl_p_lew_process_mstr.t_itm_fam_pillar_map_2;