create if not exists table IDQ_PRODUCTION.scheduler.application (
	id number(38,0) not null,
	name varchar(50) not null,
	rule_type_id number(38,0),
	timeout_minutes number(38,0),
	execution_table_name varchar(50),
	result_table_name varchar(50),
	application_name varchar(250),
	workflow_name varchar(250)
);