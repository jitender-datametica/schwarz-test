create table if not exists SZD_PRODUCTION.etl.t_etl_fact_hga_maintenance_1 (
	hga_sid number(38,0) not null comment 'the unique identifier (surrogate key) for the hot beverage machine which is loacted in a store',
	report_dt date not null comment 'the date on which the report is generated',
	cleaning_liquid_ltr_qty number(38,5) comment 'the measure of cleaning liquid solution in litre',
	service_cnt number(38,0) not null comment 'the counter of services happened on the machine for a report date',
	filter_cnt number(38,0) not null comment 'the counter of filter on the machine for a report date',
	dwh_created_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was inserted into the table.',
	dwh_updated_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	cleaning_cnt number(38,0) not null comment 'the counter of cleaning done on machine for a report date',
	door_open_cnt number(38,0) not null comment 'the number of times the door has been opened on a report date (derived from the error table based on the error type and status_1)',
	constraint pk_t_fact_hga_maintenance primary key (hga_sid, report_dt)
);