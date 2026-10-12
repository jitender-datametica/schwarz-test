create table if not exists SZD_PRODUCTION.core_rel.t_goods_movement_type_1 (
	goods_movement_type_cd varchar(50) not null comment 'the unique code of the movement type for goods.',
	goods_movement_type_descr varchar(250) not null comment 'a brief description of the movement type.',
	goods_receipt_blocked_cd varchar(50) comment 'descriptive attribute - a code used to signify a type of blocking for procurement',
	shopping_list_selection_param_txt varchar(1000) comment 'descriptive attribute - a parameter used for selection of a list by procurement',
	booking_ref_nr varchar(250) comment 'descriptive attribute - a reference number used for inventory tracking',
	debit_fg boolean not null comment 'flag indicating if it is booked as debit',
	credit_fg boolean not null comment 'flag indicating if it is booked as credit',
	dwh_created_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was inserted into the table.',
	dwh_updated_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	dwh_src_file_name varchar(500) comment 'contains the name(s) of the input file(s) that delivered the record. it can be either the full path of the blog storage or the shortened file path',
	dwh_src_1_tmsp timestamp_ltz(9) not null comment 'the extraction timestamp of the record from the source',
	constraint pk_goods_movement_type primary key (goods_movement_type_cd)
)comment='minor entity - the types of movements for goods. - source - lexis'
;