CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_geographical_area_configuration_hist_1 (
client_id INTEGER NOT NULL,
geo_area_sid INTEGER NOT NULL OPTIONS(description='Geographical Area SID'),
leaflet_valid_from_day_of_week INTEGER OPTIONS(description='Leaflet Validity_1 From Day of Week'),
leaflet_valid_to_day_of_week INTEGER OPTIONS(description='Leaflet Validity_1 To Day of Week'),
adv_plan_from_day_of_week INTEGER OPTIONS(description='Advertisement Plan From Day Of Week'),
adv_plan_to_day_of_week INTEGER OPTIONS(description='Advertisement Plan To Day Of Week'),
deleted_fg INTEGER NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (geo_area_sid, dwh_valid_from) NOT ENFORCED
);