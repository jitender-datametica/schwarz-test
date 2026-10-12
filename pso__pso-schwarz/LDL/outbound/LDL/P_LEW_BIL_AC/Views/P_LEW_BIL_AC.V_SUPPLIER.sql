CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_supplier (client_id, sup_sid, src_lifnr, src_orig_supplier_nr, name1, name2,
name3, sort1, vat_ident_no, global_location_nr, tax_no_1, main_negot_cntry_cd, country_cd_conegot, supplier_id_int,
actual_fg_supplier, actual_fg_supplier_int, actual_fg_coneg_country, active_fg_eks, active_fg_conegh, dwh_valid_from,
dwh_valid_to) AS SELECT *
FROM ldl_p_lew_bil.v_supplier;