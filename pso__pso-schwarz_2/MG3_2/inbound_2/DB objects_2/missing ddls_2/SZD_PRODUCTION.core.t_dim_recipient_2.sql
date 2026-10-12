create table if not exists SZD_PRODUCTION.core.t_dim_recipient_2 (
	party_sid number(38,0) not null comment 'the unique identifier (surrogate key) for the recipient.',
	dwh_valid_from_tmsp timestamp_ltz(9) not null comment 'the point in time when this record became valid.',
	dwh_valid_to_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was no longer valid.',
	dwh_valid_fg boolean not null comment 'an indicator showing the current record in history.',
	recipient_nr varchar(50) not null comment 'natural/business key - the business identifier of the recipient.',
	recipient_name varchar(100) not null comment 'descriptive attribute - the name of the recipient.',
	country_location_sid number(38,0) not null comment 'the unique identifier (surrogate key) for the country_2 location_2 of the recipient.',
	country_iso_cd varchar(50) not null comment 'descriptive attribute - the iso country_2 code of the country_2 of the recipient.',
	dwh_created_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was created in the data warehouse.',
	dwh_updated_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was created or last updated.',
	dwh_src_file_name varchar(500) comment 'the path and the name of the file(s) from which this record was loaded.',
	dwh_src_1_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was extracted from the source.',
	constraint pk_dim_recipient primary key (party_sid, dwh_valid_from_tmsp)
)comment='major dimension - the receipient is the party that receives the ordered goods that was ordered by a client. - source - lexis'
;