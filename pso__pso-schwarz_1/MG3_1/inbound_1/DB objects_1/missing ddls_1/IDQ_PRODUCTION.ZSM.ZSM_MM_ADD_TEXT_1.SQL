create if not exists table IDQ_PRODUCTION.zsm.zsm_mm_add_text_1 (
	mandt varchar(3),
	matnr varchar(18) not null,
	txtyp varchar(1) not null,
	text varchar(40),
	ernam varchar(12),
	erdat date,
	aenam varchar(12),
	aedat date,
	country_code varchar(2),
	td_insert timestamp_ltz(9),
	td_update timestamp_ltz(9),
	constraint pkey primary key (matnr, txtyp)
);