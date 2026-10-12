CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_GEOGRAPHICAL_AREA
(
  geo_area_sid,
  geo_area_type_cd,
  geo_area_cd,
  geo_area_name,
  geo_area_descr,
  dwh_load_id,
  dwh_created,
  dwh_updated
)
AS
SELECT
geo_area_sid,
geo_area_type_cd,
geo_area_cd,
geo_area_name,
geo_area_descr,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_core.t_geographical_area
;


