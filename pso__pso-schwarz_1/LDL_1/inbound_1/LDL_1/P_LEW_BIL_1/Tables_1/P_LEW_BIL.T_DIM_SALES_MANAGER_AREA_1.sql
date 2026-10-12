CREATE TABLE p_lew_bil.t_dim_sales_manager_area_1 (
	client_id NUMBER(38,0) NOT NULL,
	sales_manager_area_sid NUMBER(38,0) NOT NULL,
	sales_manager_nr VARCHAR(20) COLLATE 'en-ci',
	sales_manager_name VARCHAR(100),
	account_manager_area_sid NUMBER(38,0) NOT NULL,
	account_manager_nr VARCHAR(20) COLLATE 'en-ci',
	account_manager_name VARCHAR(100),
	sales_wh_sid NUMBER(38,0) NOT NULL,
	sales_wh_nr NUMBER(38,0),
	sales_region_sid NUMBER(38,0) NOT NULL,
	sales_region_manager_name VARCHAR(100),
	lidl_country_cd VARCHAR(2) NOT NULL COLLATE 'en-ci',
	lidl_country_name VARCHAR(100) NOT NULL,
	country_grp_sid NUMBER(38,0) NOT NULL,
	country_grp_manager_name VARCHAR(100),
	dwh_load_id NUMBER(38,0) NOT NULL,
	dwh_created TIMESTAMP_NTZ(9) NOT NULL,
	dwh_updated TIMESTAMP_NTZ(9) NOT NULL
)
;