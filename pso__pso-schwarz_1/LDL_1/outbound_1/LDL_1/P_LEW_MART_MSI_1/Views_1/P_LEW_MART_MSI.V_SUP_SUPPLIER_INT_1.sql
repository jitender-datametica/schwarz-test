CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_sup_supplier_int_1 AS SELECT client_id,
 sup_sid AS supplier_id,
 sup_sid_int AS supplier_id_int,
 dat_rec_start,
 dat_rec_end,
 supplier_desc_int
FROM ldl_p_lew_core_ac.v_wawi_sup_supplier_int_1
WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end;