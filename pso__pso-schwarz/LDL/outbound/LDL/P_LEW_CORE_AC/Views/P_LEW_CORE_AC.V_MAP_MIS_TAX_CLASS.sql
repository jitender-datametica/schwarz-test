CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_map_mis_tax_class (client_id, tax_class_cd, mis_vat_id, dwh_load_id,
dwh_created, dwh_updated) AS SELECT client_id,
 tax_class_cd,
 mis_vat_id,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_map_mis_tax_class;