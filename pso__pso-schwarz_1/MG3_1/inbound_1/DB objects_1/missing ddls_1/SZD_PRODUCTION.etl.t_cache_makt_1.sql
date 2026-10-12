create table if not exists SZD_PRODUCTION.etl.t_cache_makt_1 (
	mandt varchar(3000) collate 'en-ci',
	matnr varchar(3000) collate 'en-ci',
	spras varchar(3000) collate 'en-ci',
	maktx varchar(3000) collate 'en-ci',
	maktg varchar(3000) collate 'en-ci',
	extraction_date date,
	dwh_created_tmsp timestamp_ltz(9) comment 'the point in time when this record was created in the data warehouse.',
	dwh_updated_tmsp timestamp_ltz(9) comment 'the point in time when this record was created or last updated.',
	dwh_src_file_name varchar(2000),
	dwh_src_1_tmsp timestamp_ltz(9)
);