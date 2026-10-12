CREATE OR REPLACE VIEW smp_production_data_shared_ldl.p_lew_core_t_assortment_container_client_hist_2 (client_id,
assortment_container_sid, assortment_container_name, assortment_container_descr, local_assortment_container_nr,
deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 assortment_container_sid,
 assortment_container_name,
 assortment_container_descr,
 local_assortment_container_nr,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_assortment_container_client_hist_2;