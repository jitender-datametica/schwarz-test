create table if not exists SZD_PRODUCTION.core_rel.t_recipient_1 (
	party_sid number(38,0) not null comment 'the unique identifier (surrogate key) for the company.',
	dwh_valid_from_tmsp timestamp_ltz(9) not null comment 'the point in time when this record became valid.',
	dwh_valid_to_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was no longer valid.',
	dwh_valid_fg boolean not null comment 'an indicator showing the current record in history.',
	recipient_name varchar(100) not null comment 'descriptive attribute - name of the recipient',
	street_address_location_sid number(38,0) comment 'the unique identifier (surrogate key) for the location.',
	recipient_nr varchar(250) not null comment 'natural/business key - the identifying number of the internal organization',
	additional_name_1_txt varchar(1000) comment 'descriptive attribute - an additional name or part of the name of a company, may contains the type of legal entity of the company like ''gmbh'', ''limited'', co. kg'' or others but could also be just a part of a companies name',
	additional_name_2_txt varchar(1000) comment 'descriptive attribute - an additional name or part of the name of a company, may contains the type of legal entity of the company like ''gmbh'', ''limited'', co. kg'' or others but could also be just a part of a companies name',
	international_location_1_nr number(38,0) comment 'natural/business key - first part of the international location_1 number.',
	international_location_2_nr number(38,0) comment 'natural/business key - second part of the international location_1 number.',
	international_location_checksum_nr number(38,0) comment 'natural/business key - checksum for the international location_1 numbers.',
	sort_txt varchar(1000) comment 'descriptive attribute - descriptive attribute - a simple short text used for sorting',
	dwh_created_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was inserted into the table.',
	dwh_updated_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	dwh_src_file_name varchar(500) comment 'contains the name(s) of the input file(s) that delivered the record. it can be either the full path of the blog storage or the shortened file path',
	dwh_src_1_tmsp timestamp_ltz(9) not null comment 'the extraction timestamp of the record from the source',
	constraint pk_recipient primary key (party_sid, dwh_valid_from_tmsp)
)comment='major entity - the receipient is the party that receives the ordered goods that was ordered by a client. - source - lexis'
;
