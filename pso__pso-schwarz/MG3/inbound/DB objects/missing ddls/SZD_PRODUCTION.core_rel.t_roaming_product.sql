create table if not exists SZD_PRODUCTION.core_rel.t_roaming_product (
	roaming_product_id number(38,0) not null comment 'the unique identifier of the roaming product.',
	roaming_interface_cd varchar(50) not null comment 'the unique code of the roaming interface.',
	roaming_product_name varchar(100) not null comment 'natural/business key - the unique name of the roaming product.',
	dwh_created_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was inserted into the table.',
	dwh_updated_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	dwh_src_file_name varchar(500) comment 'contains the name(s) of the input file(s) that delivered the record. it can be either the full path of the blob storage or the shortened file path',
	dwh_src_1_tmsp timestamp_ltz(9) not null comment 'the extraction timestamp of the record from the source',
	constraint pk_roaming_product primary key (roaming_product_id)
)comment='minor entity - the roaming tariff used when roaming is active during a charging session. roaming is active if the operator of the charge point is different from the seller of the power for charging the car. - source iotcharger'
;