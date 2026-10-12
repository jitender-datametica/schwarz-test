create if not exists table IDQ_PRODUCTION.zsm.wyt1_2 (
	mandt varchar(3),
	lifnr varchar(10) not null,
	ltsnr varchar(6) not null,
	ernam varchar(12),
	erdat date,
	country_code varchar(2),
	td_insert timestamp_ltz(9),
	td_update timestamp_ltz(9),
	constraint pkey primary key (lifnr, ltsnr)
);