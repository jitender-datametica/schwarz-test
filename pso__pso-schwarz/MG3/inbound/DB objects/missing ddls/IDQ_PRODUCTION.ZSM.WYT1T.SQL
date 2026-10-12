create if not exists table IDQ_PRODUCTION.zsm.wyt1t (
	mandt varchar(3) not null,
	spras varchar(1) not null,
	lifnr varchar(10) not null,
	ltsnr varchar(6) not null,
	ltsbz varchar(20),
	country_code varchar(2),
	td_insert timestamp_ltz(9),
	td_update timestamp_ltz(9),
	constraint pkey primary key (mandt, spras, lifnr, ltsnr)
);