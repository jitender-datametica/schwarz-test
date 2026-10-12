CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_sup_category (client_id, supplier_category_id, dat_rec_start,
dat_rec_end, supplier_category_desc, load_id) AS SELECT client_id,
 supplier_category_id,
 dat_rec_start,
 dat_rec_end,
 supplier_category_desc,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_sup_category;