create table if not exists SZD_PRODUCTION.core_rel.t_power_type_1 (
	power_type_cd varchar(50) not null comment 'the code for the type of power.',
	power_type_descr varchar(250) not null comment 'the description for the type of power (ac = alternating current, dc = direct current)',
	dwh_created_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was inserted into the table.',
	dwh_updated_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	dwh_src_file_name varchar(500) comment 'contains the name(s) of the input file(s) that delivered the record. it can be either the full path of the blog storage or the shortened file path',
	dwh_src_1_tmsp timestamp_ltz(9) not null comment 'the extraction timestamp of the record from the source',
	constraint pk_power_type primary key (power_type_cd)
)comment='minor entity - this minor entity describes the type of power (ac = alternating current, dc = direct current). - source - iot charger'
;