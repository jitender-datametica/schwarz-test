create table if not exists SZD_PRODUCTION.etl.t_cache_t023t (
	mandt varchar(3000),
	spras varchar(3000),
	matkl varchar(3000),
	wgbez varchar(3000),
	wgbez60 varchar(3000),
	extraction_date date,
	dwh_created_tmsp timestamp_ltz(9) comment 'the point in time when this record was created in the data warehouse.',
	dwh_updated_tmsp timestamp_ltz(9) comment 'the point in time when this record was created or last updated.',
	dwh_src_file_name varchar(2000),
	dwh_src_1_tmsp timestamp_ltz(9)
);