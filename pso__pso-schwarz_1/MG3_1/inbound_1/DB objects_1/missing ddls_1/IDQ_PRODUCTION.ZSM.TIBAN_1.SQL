create if not exists table IDQ_PRODUCTION.zsm.tiban_1 (
	mandt varchar(3) not null,
	banks varchar(3) not null,
	bankl varchar(15) not null,
	bankn varchar(35) not null,
	bkont varchar(2) not null,
	iban varchar(34),
	valid_from date,
	ernam varchar(12),
	erdat date,
	tabname varchar(16),
	tabkey varchar(24),
	country_code varchar(2),
	td_insert timestamp_ltz(9),
	td_update timestamp_ltz(9),
	constraint pkey primary key (mandt, banks, bankl, bankn, bkont)
);