CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_subitemgroup_desc_2 (client_id, subitemgroup_id, dat_rec_start,
dat_rec_end, subitemgroup_desc, subitemgroup_short_desc, subitemgroup_sortterm, language_id, load_id) AS SELECT
 client_id,
 subitemgroup_id,
 dat_rec_start,
 dat_rec_end,
 subitemgroup_desc,
 subitemgroup_short_desc,
 subitemgroup_sortterm,
 language_id,
 load_id
FROM ldl_p_lew_core.t_wawi_itm_subitemgroup_desc_2;