create table if not exists SZD_PRODUCTION.core_rel.t_charge_point_enabled_interface_rel (
	resource_item_sid number(38,0) not null comment 'the unique identifier (surrogate key) for the charge point.',
	roaming_interface_cd varchar(50) not null comment 'the unique code of the roaming interface.',
	dwh_valid_from_tmsp timestamp_ltz(9) not null comment 'the point in time when this record became valid.',
	dwh_valid_to_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was no longer valid.',
	dwh_valid_fg boolean not null comment 'an indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	dwh_created_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was inserted into the table.',
	dwh_updated_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	dwh_src_file_name varchar(500) comment 'contains the name(s) of the input file(s) that delivered the record. it can be either the full path of the blob storage or the shortened file path',
	dwh_src_1_tmsp timestamp_ltz(9) not null comment 'the extraction timestamp of the record from the source',
	constraint pk_charge_point_enabled_interface_rel primary key (resource_item_sid, roaming_interface_cd, dwh_valid_from_tmsp)
)comment='bridge table - contains the enabled roaming interfaces of the charge points. - source iotcharger'
;