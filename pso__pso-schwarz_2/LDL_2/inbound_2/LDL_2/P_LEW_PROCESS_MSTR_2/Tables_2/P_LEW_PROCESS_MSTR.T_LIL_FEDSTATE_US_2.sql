CREATE TABLE p_lew_process_mstr.t_lil_fedstate_us_2 (
	client_id INTEGER NOT NULL,
	region_sid INTEGER NOT NULL,
	fedstate_cd VARCHAR(160) NOT NULL,
	valid_from DATE NOT NULL,
	valid_to DATE NOT NULL,
	active_fg BYTEINT NOT NULL,
	dwh_load_id INTEGER NOT NULL,
	DWH_CREATED TIMESTAMP_LTZ(9) NOT NULL,
	DWH_UPDATED TIMESTAMP_LTZ(9) NOT NULL,
	TD_INSERT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9),
CONSTRAINT t_lil_us_regions_pk PRIMARY KEY ( region_sid ,fedstate_cd ,valid_from )
);