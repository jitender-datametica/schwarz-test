create table if not exists SZD_PRODUCTION.core_rel.t_roaming_interface_2 (
	roaming_interface_cd varchar(50) not null comment 'the unique code of the roaming interface.',
	roaming_interface_descr varchar(250) not null comment 'a brief description of the roaming interface.',
	dwh_created_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was inserted into the table.',
	dwh_updated_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	dwh_src_file_name varchar(500) comment 'contains the name(s) of the input file(s) that delivered the record. it can be either the full path of the blog storage or the shortened file path',
	dwh_src_1_tmsp timestamp_ltz(9) not null comment 'the extraction timestamp of the record from the source',
	constraint pk_roaming_interface primary key (roaming_interface_cd)
)comment='minor entity - the roaming interface determines the type of billing between two different providers (e.g. lidl and kaufland). - source - manual'
;