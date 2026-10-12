CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_sup_suppliergroup_2 (client_id, suppliergroup_id, dat_rec_start,
dat_rec_end, suppliergroup_desc, language_id, load_id) AS SELECT client_id,
 suppliergroup_id,
 dat_rec_start,
 dat_rec_end,
 suppliergroup_desc,
 language_id,
 load_id
FROM ldl_p_lew_core.t_wawi_sup_suppliergroup_2;