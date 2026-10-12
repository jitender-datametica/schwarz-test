create if not exists table LDL_PRODUCTION.p_lew_core.t_wawi_ref_language_2 (
	language_id number(38,0) not null,
	language_iso_cd varchar(3) not null collate 'en-ci',
	language_desc varchar(35) not null collate 'en-ci',
	load_id number(38,0) not null,
	unique (language_id)
);