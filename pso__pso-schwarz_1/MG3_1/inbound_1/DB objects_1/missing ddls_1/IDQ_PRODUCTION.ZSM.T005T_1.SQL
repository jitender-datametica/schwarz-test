create if not exists table IDQ_PRODUCTION.zsm.t005t_1 (
	mandt varchar(3),
	spras varchar(1) not null,
	land1 varchar(3) not null,
	landx varchar(15),
	natio varchar(15),
	landx50 varchar(50),
	natio50 varchar(50),
	prq_spregt varchar(30),
	country_code varchar(2),
	td_insert timestamp_ltz(9),
	td_update timestamp_ltz(9),
	constraint pkey primary key (spras, land1)
);