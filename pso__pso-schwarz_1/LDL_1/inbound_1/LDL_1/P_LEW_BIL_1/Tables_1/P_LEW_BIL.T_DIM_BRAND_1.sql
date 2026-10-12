CREATE TABLE p_lew_bil.t_dim_brand_1 (
	client_id NUMBER(38,0) NOT NULL,
	brand_sid NUMBER(38,0) NOT NULL,
	brand_name VARCHAR(100) NOT NULL,
	dwh_load_id NUMBER(38,0) NOT NULL,
	dwh_created TIMESTAMP_NTZ(9) NOT NULL,
	dwh_updated TIMESTAMP_NTZ(9) NOT NULL,
	UNIQUE (client_id, brand_sid)
)
;