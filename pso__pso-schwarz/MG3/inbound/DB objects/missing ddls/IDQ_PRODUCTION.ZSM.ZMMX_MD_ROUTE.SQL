create if not exists table IDQ_PRODUCTION.zsm.zmmx_md_route (
	mandt varchar(3) not null,
	route_id varchar(6) not null,
	supplier_route_id number(38,0),
	logistic_route_id number(38,0),
	route_descr_short varchar(25),
	route_descr varchar(80),
	travelroute_id_old number(38,0),
	charge_type varchar(1),
	land varchar(3),
	nr_pos number(38,0),
	country_code varchar(2),
	td_insert timestamp_ltz(9),
	td_update timestamp_ltz(9),
	constraint pkey primary key (mandt, route_id)
);