create table if not exists SZD_PRODUCTION.core_rel.t_real_estate_2 (
	resource_item_sid number(38,0) not null comment 'the unique identifier (surrogate key) for the resource item.',
	dwh_valid_from_tmsp timestamp_ltz(9) not null comment 'the point in time when this record became valid.',
	dwh_valid_to_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was no longer valid.',
	dwh_valid_fg boolean not null comment 'an indicator showing the current record in history.',
	street_address_location_sid number(38,0) not null comment 'the unique identifier (surrogate key) for the location.',
	country_location_sid number(38,0) not null comment 'the unique identifier (surrogate key) for the political country.',
	division_party_sid number(38,0) not null comment 'the unique identifier (surrogate key) for the party as a division. key generation based on meta table for party key space.',
	real_estate_nr varchar(250) not null comment 'the unique code of the real estate within the country.',
	dwh_created_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was inserted into the table.',
	dwh_updated_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	dwh_src_file_name varchar(500) comment 'contains the name(s) of the input file(s) that delivered the record. it can be either the full path of the blog storage or the shortened file path',
	dwh_src_1_tmsp timestamp_ltz(9) not null comment 'the extraction timestamp of the record from the source',
	constraint pk_real_estate primary key (resource_item_sid, dwh_valid_from_tmsp)
)comment='major entity - a real estate is a non-movable building such as a store or a parking garage. - source - iotcharger'
;