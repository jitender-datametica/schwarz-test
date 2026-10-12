CREATE OR REPLACE VIEW p_lew_core_ac.v_geographical_area_configuration_hist
(
 client_id
,geo_area_sid
,leaflet_valid_from_day_of_week
,leaflet_valid_to_day_of_week
,adv_plan_from_day_of_week
,adv_plan_to_day_of_week
,deleted_fg
,dwh_valid_from
,dwh_valid_to
,dwh_load_id
,dwh_created
,dwh_updated
)
AS
SELECT
client_id,
geo_area_sid,
leaflet_valid_from_day_of_week,
leaflet_valid_to_day_of_week,
adv_plan_from_day_of_week,
adv_plan_to_day_of_week,
deleted_fg,
dwh_valid_from,
dwh_valid_to,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_core.t_geographical_area_configuration_hist
;



