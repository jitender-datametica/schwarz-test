CREATE OR REPLACE VIEW smp_production_data_shared_ldl.p_lew_core_t_wawi_ref_order_area_2 (client_id, order_area_cd,
order_area_desc, language_id, load_id) AS SELECT client_id,
 order_area_cd,
 order_area_desc,
 language_id,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_order_area_2;