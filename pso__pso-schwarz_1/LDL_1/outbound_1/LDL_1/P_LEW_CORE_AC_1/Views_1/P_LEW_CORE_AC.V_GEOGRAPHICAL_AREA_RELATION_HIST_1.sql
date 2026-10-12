CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_geographical_area_relation_hist_1 (geo_area_sid, geo_area_type_cd, geo_area_cd
, geo_area_rel_type_cd, rel_geo_area_sid, rel_geo_area_type_cd, rel_geo_area_cd, deleted_fg, dwh_valid_from,
dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT geo_area_sid,
 geo_area_type_cd,
 geo_area_cd,
 geo_area_rel_type_cd,
 rel_geo_area_sid,
 rel_geo_area_type_cd,
 rel_geo_area_cd,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_geographical_area_relation_hist_1;