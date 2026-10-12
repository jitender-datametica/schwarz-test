CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_GEOGRAPHICAL_AREA_RELATION_TYPE_2
(
  geo_area_rel_type_cd,
  geo_area_rel_type_descr,
  dwh_load_id,
  dwh_created,
  dwh_updated
)
AS
SELECT
geo_area_rel_type_cd,
geo_area_rel_type_descr,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_core.t_ref_geographical_area_relation_type_2
;


