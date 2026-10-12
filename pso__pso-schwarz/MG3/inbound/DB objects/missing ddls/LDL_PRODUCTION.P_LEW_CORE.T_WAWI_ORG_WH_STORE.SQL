create if not exists table LDL_PRODUCTION.p_lew_core.t_wawi_org_wh_store (
	client_id number(38,0) not null,
	st_loc_sid number(38,0) not null,
	wh_type_id number(38,0) not null,
	dat_rec_start date not null,
	dat_rec_end date not null,
	wh_loc_sid number(38,0) not null,
	load_id number(38,0) not null
);