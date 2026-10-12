CREATE OR REPLACE VIEW p_lew_precore_ac.v_cache_advert_week_hist_2
(
 client_id
,country_cd
,valid_from_dt
,valid_to_dt
,plan_first_day
,plan_last_day
,leaflet_start_day
,leaflet_end_day
,file_name
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
country_cd,
valid_from_dt,
valid_to_dt,
plan_first_day,
plan_last_day,
leaflet_start_day,
leaflet_end_day,
file_name,
deleted_fg,
dwh_valid_from,
dwh_valid_to,
dwh_load_id,
dwh_created,
dwh_updated
FROM p_lew_precore.t_cache_advert_week_hist_2 ;




