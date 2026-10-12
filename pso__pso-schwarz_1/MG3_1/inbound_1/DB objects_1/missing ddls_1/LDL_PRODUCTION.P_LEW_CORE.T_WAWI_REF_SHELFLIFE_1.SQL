create if not exists table LDL_PRODUCTION.p_lew_core.t_wawi_ref_shelflife_1 (
	client_id number(38,0) not null,
	shelflife_id number(38,0) not null,
	shelflife_short_desc varchar(35) collate 'en-ci',
	shelflife_desc varchar(50) collate 'en-ci',
	language_id number(38,0) not null,
	dat_rec_start date not null,
	dat_rec_end date not null,
	factor_period number(38,0),
	load_id number(38,0) not null
);