CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_sup_vat_id_2 (client_id, sup_sid, vat_ident_nr, dat_rec_start, dat_rec_end
, supplier_category_id, load_id) AS SELECT client_id,
 sup_sid,
 vat_ident_nr,
 dat_rec_start,
 dat_rec_end,
 supplier_category_id,
 load_id
FROM ldl_p_lew_core.t_wawi_sup_vat_id_2;