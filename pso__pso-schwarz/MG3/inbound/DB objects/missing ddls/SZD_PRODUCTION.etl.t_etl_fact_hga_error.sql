create table if not exists SZD_PRODUCTION.etl.t_etl_fact_hga_error (
	hga_sid number(38,0) not null comment 'the unique identifier (surrogate key) for the hot beverage machine which is loacted in a store',
	error_tmsp timestamp_tz(9) not null comment 'the timestamp of the error occurence ',
	hga_error_cd varchar(250) not null comment 'the code of error occured (error name)',
	hga_error_type_id number(38,0) not null comment 'the unique identifier for the hga error type',
	error_status_fg boolean not null comment 'the indicator for the status of error (true or false)',
	is_in_operation_fg boolean not null comment 'the indicator for hot beverage automate beeing in operation = true, if only partial failure, if total failure then false',
	manufacturer_sid number(38,0) not null comment 'the unique identifier (surrogate key) for a company which produces deposit machines.',
	dwh_created_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was inserted into the table.',
	dwh_updated_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint pk_t_fact_hga_error primary key (hga_sid, error_tmsp, hga_error_cd, error_status_fg)
);