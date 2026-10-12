CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_geographical_area_type (geo_area_type_cd, geo_area_type_descr,
dwh_load_id, dwh_created, dwh_updated) AS SELECT geo_area_type_cd,
 geo_area_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_geographical_area_type;