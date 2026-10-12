create if not exists table LDL_PRODUCTION.p_lew_core.t_wawi_itm_sup_wh_buying_price_1 (
	client_id number(38,0) not null,
	wh_loc_sid number(38,0) not null,
	item_sid number(38,0) not null,
	sup_sid number(38,0) not null,
	dat_rec_start date not null,
	dat_rec_end date not null,
	dat_valid_from date not null,
	dat_valid_until date,
	dat_valid_until_group date,
	currency_nr number(38,0),
	group_nr number(18,0),
	delivery_item_cd varchar(3) collate 'en-ci',
	dur_shelflife_cust varchar(10) collate 'en-ci',
	period_id_shelflife_cust number(38,0),
	dur_shelflife_store varchar(10) collate 'en-ci',
	period_id_shelflife_store number(38,0),
	dur_shelflife_wh varchar(10) collate 'en-ci',
	period_id_shelflife_wh number(38,0),
	price_buying number(38,5) not null,
	price_buying_special number(38,5),
	currency_nr_special number(38,0),
	origin_country_cd varchar(3) collate 'en-ci',
	load_id number(38,0) not null,
	buying_list_type_id number(38,0),
	constraint pk_t_wawi_itm_sup_wh_buying_price primary key (client_id)
)comment='2do:
             table comment
             pk'
;