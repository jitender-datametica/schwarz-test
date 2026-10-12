CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_sup_supplier_skey (client_id, sup_sid, dat_rec_start, dat_rec_end,
orig_supplier_nr, load_id) AS SELECT client_id,
 sup_sid,
 dat_rec_start,
 dat_rec_end,
 orig_supplier_nr,
 load_id
FROM ldl_p_lew_core.t_wawi_sup_supplier_skey;