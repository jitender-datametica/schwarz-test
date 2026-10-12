CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_GEOGRAPHICAL_AREA_RELATION_HIST_2
(
  geo_area_sid,
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
)
AS
SELECT
geo_area_sid,
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
FROM p_lew_core.t_geographical_area_relation_hist_2
;







