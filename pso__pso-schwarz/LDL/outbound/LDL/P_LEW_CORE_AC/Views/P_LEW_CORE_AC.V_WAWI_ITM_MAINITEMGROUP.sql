CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_mainitemgroup (client_id, mainitemgroup_id, dat_rec_start,
dat_rec_end, mainitemgroup_desc, mainitemgroup_short_desc, mainitemgroup_sortterm, language_id, load_id) AS SELECT
 client_id,
 mainitemgroup_id,
 dat_rec_start,
 dat_rec_end,
 mainitemgroup_desc,
 mainitemgroup_short_desc,
 mainitemgroup_sortterm,
 language_id,
 load_id
FROM ldl_p_lew_core.t_wawi_itm_mainitemgroup;