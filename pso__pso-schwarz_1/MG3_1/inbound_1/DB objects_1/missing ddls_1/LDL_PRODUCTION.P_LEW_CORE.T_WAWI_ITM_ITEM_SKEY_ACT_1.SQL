create if not exists table LDL_PRODUCTION.p_lew_core.t_wawi_itm_item_skey_act_1 (
	client_id number(38,0) not null,
	item_sid number(38,0) not null,
	orig_item_nr number(18,0) not null,
	case_size number(38,0) not null,
	reused_nr number(38,0),
	dat_deleted date not null default cast('9999-12-31' as date),
	deleted_rmi_fg number(38,0) not null default 0
);