CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_geographical_area_1 (geo_area_sid, geo_area_type_cd, geo_area_cd, geo_area_name
, geo_area_descr, dwh_load_id, dwh_created, dwh_updated) AS SELECT geo_area_sid,
 geo_area_type_cd,
 geo_area_cd,
 geo_area_name,
 geo_area_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_geographical_area_1;