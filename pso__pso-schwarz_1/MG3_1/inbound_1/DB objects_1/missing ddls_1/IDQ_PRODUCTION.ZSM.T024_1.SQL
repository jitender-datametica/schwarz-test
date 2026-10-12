create if not exists table IDQ_PRODUCTION.zsm.t024_1 (
	mandt varchar(3),
	ekgrp varchar(3) not null,
	eknam varchar(18),
	ektel varchar(12),
	ldest varchar(4),
	telfx varchar(31),
	tel_number varchar(30),
	tel_extens varchar(10),
	smtp_addr varchar(241),
	country_code varchar(2),
	td_insert timestamp_ltz(9),
	td_update timestamp_ltz(9),
	constraint pkey primary key (ekgrp)
);