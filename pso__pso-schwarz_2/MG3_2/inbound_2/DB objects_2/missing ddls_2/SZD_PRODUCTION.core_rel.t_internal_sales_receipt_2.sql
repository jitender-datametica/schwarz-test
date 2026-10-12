create table if not exists SZD_PRODUCTION.core_rel.t_internal_sales_receipt_2 (
	sales_receipt_nr varchar(250) not null comment 'the business receipt number of the internal sales_2 receipt.',
	recipient_party_sid number(38,0) not null comment 'the unique identifier (surrogate key) for the party.',
	receipt_dt date not null comment 'the date of the receipt.',
	desired_dt date not null comment 'the desired delivery date of the client.',
	invoice_dt date not null comment 'the date of the invoice.',
	permitted_partial_delivery_cnt number(38,0) not null comment 'fact - additive - the count of permitted partial deliveries per position.',
	receipt_condition_nr varchar(250) not null comment 'the number of the receipt condition.',
	dwh_created_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was inserted into the table.',
	dwh_updated_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	dwh_src_file_name varchar(500) comment 'contains the name(s) of the input file(s) that delivered the record. it can be either the full path of the blog storage or the shortened file path',
	dwh_src_1_tmsp timestamp_ltz(9) not null comment 'the extraction timestamp of the record from the source',
	constraint pk_internal_sales_receipt primary key (sales_receipt_nr)
)comment='entity - transactional - contains receipts for the internal sale of goods to stores from the lexis system. - source - lexis'
;