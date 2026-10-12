create if not exists table LDL_PRODUCTION.p_lew_core.t_wawi_ref_packagetype (
	client_id number(38,0) not null,
	packagetype_desc varchar(35) not null collate 'en-ci',
	packagetype_desc_int_short varchar(35) not null collate 'en-ci',
	language_id number(38,0) not null,
	load_id number(38,0) not null
);