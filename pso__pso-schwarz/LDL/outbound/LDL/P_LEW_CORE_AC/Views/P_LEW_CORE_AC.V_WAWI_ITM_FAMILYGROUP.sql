CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_familygroup (client_id, item_familygroup_id, dat_rec_start,
dat_rec_end, subitemgroup_id, family_cd, item_family_desc, item_family_short_desc, language_id, load_id) AS SELECT
 client_id,
 item_familygroup_id,
 dat_rec_start,
 dat_rec_end,
 subitemgroup_id,
 family_cd,
 item_family_desc,
 item_family_short_desc,
 language_id,
 load_id
FROM ldl_p_lew_core.t_wawi_itm_familygroup;