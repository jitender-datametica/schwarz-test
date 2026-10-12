create table if not exists SZD_PRODUCTION.core_rel.t_delivery_wave_2 (
	distribution_nr varchar(250) not null comment 'the business number of the distribution.',
	distribution_position_nr number(38,0) not null comment 'the number of the position of the delivery.',
	wave_nr number(38,0) not null comment 'the number of the wave of the delivery position.',
	distribution_store_group_nr number(38,0) not null comment 'todo',
	delivery_dt date comment 'the deliviery date of this wave.',
	distribution_qty number(38,5) comment 'the quantity to be delivered in this wave,',
	distribution_unit_id number(38,0) not null comment 'the number identifying the distribution quantity unit_2 of measure.',
	order_qty number(38,5) comment 'the ordered quantity.',
	order_unit_id number(38,0) not null comment 'the number identifying the order quantity unit_2 of measure.',
	desired_qty number(38,5) comment 'the desired quantity.',
	order_dt date comment 'the order date.',
	dwh_created_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was inserted into the table.',
	dwh_updated_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	dwh_src_file_name varchar(500) comment 'contains the name(s) of the input file(s) that delivered the record. it can be either the full path of the blog storage or the shortened file path',
	dwh_src_1_tmsp timestamp_ltz(9) not null comment 'the extraction timestamp of the record from the source',
	constraint pk_t_delivery_wave primary key (distribution_position_nr, wave_nr, distribution_nr, distribution_store_group_nr)
)comment='entity - transactional - transaction - a wave of a delivery is a scheduled partial delivery of the goods to the target (e.g. a store) . - source - lexis'
;