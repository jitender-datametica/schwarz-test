create if not exists table LDL_PRODUCTION.p_lew_core.t_item_location_stock_hist_2 cluster by (client_id, dwh_valid_from, dwh_valid_to)(
	client_id number(38,0) not null,
	item_sid number(38,0) not null,
	loc_sid number(38,0) not null,
	src_space_switch number(38,0) not null,
	price number(18,5),
	price_net number(18,5),
	calc_qty number(18,5) not null,
	inv_qty number(18,5) not null,
	diff_qty_inv_calc number(18,5) not null,
	deleted_fg number(38,0) not null,
	dwh_valid_from date not null,
	dwh_valid_to date not null,
	dwh_last_confirm_dt date not null,
	dwh_load_id number(38,0) not null,
	dwh_created timestamp_ntz(9) not null,
	dwh_updated timestamp_ntz(9) not null,
	store_storage_qty number(38,5)
);