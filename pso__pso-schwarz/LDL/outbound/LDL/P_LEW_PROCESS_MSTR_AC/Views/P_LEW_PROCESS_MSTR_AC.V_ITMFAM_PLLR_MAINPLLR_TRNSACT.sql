CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_itmfam_pllr_mainpllr_trnsact (src_familygrp_cd, item_fam_grp_name,
pillar_id, pillar_name, main_pillar_id, main_pillar_name) AS SELECT *
FROM ldl_p_lew_process_mstr.v_itmfam_pllr_mainpllr_trnsact;