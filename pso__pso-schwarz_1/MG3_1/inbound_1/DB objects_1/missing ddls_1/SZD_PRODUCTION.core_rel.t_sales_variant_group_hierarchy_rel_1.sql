create table if not exists SZD_PRODUCTION.core_rel.t_sales_variant_group_hierarchy_rel_1 (
	product_group_sid number(38,0) not null comment 'major entity - the sales_1 variant group is a special product group for sales_1 variants. - source - lexis',
	parent_product_group_sid number(38,0) not null comment 'major entity - the sales_1 variant group is a special product group for sales_1 variants. - source - lexis',
	dwh_valid_from_tmsp timestamp_ltz(9) not null comment 'the point in time when this record became valid.',
	dwh_valid_to_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was no longer valid.',
	dwh_valid_fg boolean not null comment 'an indicator showing the current record in history.',
	dwh_created_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was created in the data warehouse.',
	dwh_updated_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was created or last updated.',
	dwh_src_file_name varchar(500) comment 'contains the name(s) of the input file(s) that delivered the record. it can be either the full path of the blog storage or the shortened file path.',
	dwh_src_1_tmsp timestamp_ltz(9) not null comment 'the extraction timestamp of the record from the source.',
	constraint pk_sales_variant_group_hierarchy_rel primary key (product_group_sid, dwh_valid_from_tmsp)
)comment='bridge entity - contains the hierarchy_1 dependencies between sales_1 variant groups and their parent groups. - source - sap lexis'
;