CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_assortment_container (assortment_container_sid, container_client_id,
assortment_container_nr, dwh_load_id, dwh_created, dwh_updated) AS SELECT assortment_container_sid,
 container_client_id,
 assortment_container_nr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_assortment_container;