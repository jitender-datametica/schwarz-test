create if not exists table LDL_PRODUCTION.p_lew_core.t_wawi_itm_ean (
	client_id number(38,0) not null comment 'dwh-mandant; fk auf client; table name before the trans-all migration: client_id',
	item_sid number(38,0) not null comment 'systemgenerierte artikelnummer; table name before the trans-all migration: item_sid',
	dat_rec_start date not null comment 'column name before the trans-all migration: dat_rec_start',
	dat_rec_end date not null comment 'column name before the trans-all migration: dat_rec_end',
	ean varchar(13) not null collate 'en-ci' comment 'column name before the trans-all migration: ean',
	ean_item_desc varchar(50) comment 'column name before the trans-all migration: ean_item_desc',
	custom_nr varchar(100) collate 'en-ci' comment 'column name before the trans-all migration: custom_nr',
	custom_key varchar(100) collate 'en-ci' comment 'column name before the trans-all migration: custom_key',
	language_id number(38,0) not null comment 'sprache; table name before the trans-all migration: language_id',
	load_id number(38,0) not null comment 'identifier des letzten ladelaufs, der den datensatz eingfuegt oder veraendert hat; table name before the trans-all migration: load_id',
	ean_item_long_descr varchar(250) comment 'extended desription of the ean
            wawi: arteancodes.online_desc',
	constraint pk_t_wawi_itm_ean primary key (client_id, item_sid, dat_rec_start, ean, language_id)
)comment='$revision: 5995 $. auto generated  9/27/2017'
;