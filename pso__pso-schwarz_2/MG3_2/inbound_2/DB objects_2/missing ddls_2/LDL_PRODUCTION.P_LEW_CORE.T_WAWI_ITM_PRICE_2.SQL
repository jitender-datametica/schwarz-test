create if not exists table LDL_PRODUCTION.p_lew_core.t_wawi_itm_price_2 (
	client_id number(38,0) not null comment 'dwh-mandant_2; fk auf client; table name before the trans-all migration: client_id',
	item_sid number(38,0) not null comment 'column name before the trans-all migration: item_sid',
	pricegroup_id number(8,0) not null comment 'column name before the trans-all migration: pricegroup_id',
	dat_valid_from date not null comment 'column name before the trans-all migration: dat_valid_from',
	dat_valid_until date not null comment 'column name before the trans-all migration: dat_valid_until',
	vat_id number(38,0) not null comment 'column name before the trans-all migration: vat_id',
	tare_cd number(38,0) comment 'column name before the trans-all migration: tare_cd',
	price_retail number(18,4) comment 'column name before the trans-all migration: price_retail',
	price_retail_net number(19,5) comment 'column name before the trans-all migration: price_retail_net',
	val_refund number(18,4) comment 'column name before the trans-all migration: val_refund',
	val_net_refund number(19,5) comment 'column name before the trans-all migration: val_net_refund',
	val_beverage_tax number(18,4) comment 'column name before the trans-all migration: val_beverage_tax',
	load_id number(38,0) not null comment 'identifier des letzten ladelaufs, der den datensatz eingfuegt oder veraendert hat; table name before the trans-all migration: load_id',
	pcwo_reason_id number(38,0) comment 'reason identifier for price changes, subset of general set of identifiers of write off and price change reasons
                        wawi:  t201_itemprices.c201_reason_id',
	constraint pk_t_wawi_itm_price primary key (item_sid, pricegroup_id, dat_valid_from, dat_valid_until)
)comment='data from wawi table t201_itemprices_2 '
;