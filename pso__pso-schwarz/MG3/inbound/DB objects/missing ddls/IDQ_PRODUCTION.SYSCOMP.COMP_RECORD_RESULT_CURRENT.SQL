create if not exists table IDQ_PRODUCTION.syscomp.comp_record_result_current (
	scope_id number(38,0) not null,
	comp_definition_scope_id number(38,0) not null,
	leading_test_object_id number(38,0) not null,
	dependent_test_object_id number(38,0) not null,
	matching_status_id number(38,0) not null,
	unmatched_tables varchar(200),
	first_negative_test timestamp_ntz(9),
	first_positive_test timestamp_ntz(9),
	error_solved number(38,0) not null,
	flip_count number(38,0) not null,
	due_date timestamp_ntz(9),
	first_negative_test_day_id number(38,0) not null,
	first_positive_test_day_id number(38,0) not null,
	due_day_id number(38,0) not null
);