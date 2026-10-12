create table if not exists SZD_PRODUCTION.core_rel.t_delivery_distribution_1 (
	distribution_nr varchar(250) not null comment 'the business number of the distribution.',
	event_dt date not null comment 'the timestamp when the information was created or last updated',
	activity_state_id number(38,0) not null comment 'the unique id of the activity state.',
	maintenance_state_id number(38,0) not null comment 'the unique id of the maintenance state.',
	delivery_distribution_type_cd varchar(50) not null comment 'the unique code of the delivery distribution type code.',
	purchasing_group_nr varchar(250) comment 'descriptive attribute - the business identifier of the purchasing group.',
	distribution_descr varchar(250) comment 'descriptive attribute - a brief description text of the distribution.',
	decommissioning_month number(38,0) comment 'descriptive attribute - the month of decommisioning in the format of yymm (e.g. 1707 for july 2017).',
	dwh_created_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was inserted into the table.',
	dwh_updated_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.',
	dwh_src_file_name varchar(500) comment 'contains the name(s) of the input file(s) that delivered the record. it can be either the full path of the blog storage or the shortened file path.',
	dwh_src_1_tmsp timestamp_ltz(9) not null comment 'the extraction timestamp of the record from the source.',
	constraint pk_delivery_distribution primary key (distribution_nr, event_dt)
)comment='entity - transactional - transaction - containts information of a distribution of goods from a warehouse or supplier_1 to one or more stores. - source - lexis'
;