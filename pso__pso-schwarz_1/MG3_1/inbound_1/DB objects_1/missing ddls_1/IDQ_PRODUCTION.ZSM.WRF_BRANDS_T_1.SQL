create if not exists table IDQ_PRODUCTION.zsm.wrf_brands_t_1 (
	mandt varchar(3),
	brand_id varchar(4) not null,
	language varchar(1) not null,
	brand_descr varchar(30),
	country_code varchar(2),
	td_insert timestamp_ltz(9),
	td_update timestamp_ltz(9),
	constraint pkey primary key (brand_id, language)
);