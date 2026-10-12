CREATE OR REPLACE VIEW smp_production_data_shared_ldl.p_lew_core_t_supplier_1 (client_id, sup_sid, src_lifnr,
src_supplier_id, src_orig_supplier_nr, sup_name, tax_no_1, vat_ident_no, dwh_load_id, dwh_created, dwh_updated) AS
SELECT client_id,
 sup_sid,
 src_lifnr,
 src_supplier_id,
 src_orig_supplier_nr,
 sup_name,
 tax_no_1,
 vat_ident_no,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_supplier_1;