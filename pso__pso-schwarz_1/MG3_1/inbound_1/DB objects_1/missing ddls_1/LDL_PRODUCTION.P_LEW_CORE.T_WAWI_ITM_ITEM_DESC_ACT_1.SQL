create if not exists table LDL_PRODUCTION.p_lew_core.t_wawi_itm_item_desc_act_1 (
	client_id number(38,0) not null,
	item_sid number(38,0) not null,
	item_desc varchar(50) collate 'en-ci',
	orig_item_nr number(10,0),
	language_id number(38,0) not null
);