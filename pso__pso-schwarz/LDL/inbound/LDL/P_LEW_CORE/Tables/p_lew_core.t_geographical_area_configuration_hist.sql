CREATE TABLE p_lew_core.t_geographical_area_configuration_hist
(
client_id INTEGER NOT NULL,
geo_area_sid INTEGER NOT NULL COMMENT 'Geographical Area SID',
leaflet_valid_from_day_of_week BYTEINT COMMENT 'Leaflet Validity From Day of Week',
leaflet_valid_to_day_of_week BYTEINT COMMENT 'Leaflet Validity To Day of Week',
adv_plan_from_day_of_week BYTEINT COMMENT 'Advertisement Plan From Day Of Week',
adv_plan_to_day_of_week BYTEINT COMMENT 'Advertisement Plan To Day Of Week',
deleted_fg BYTEINT NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id INTEGER NOT NULL,
DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL,
CONSTRAINT t_geographical_area_configuration_hist_pk PRIMARY KEY ( geo_area_sid ,
dwh_valid_from ));

