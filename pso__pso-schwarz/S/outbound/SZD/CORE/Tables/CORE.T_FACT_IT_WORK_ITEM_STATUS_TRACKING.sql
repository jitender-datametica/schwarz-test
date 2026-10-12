/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_IT_WORK_ITEM_STATUS_TRACKING
   generated from Powerdesigner on Dienstag, 30. April 2024 14:55:27
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_fact_it_work_item_status_tracking (
it_work_item_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the resource item. as an IT ressource. Key generation based on META table for party key space.'),
it_work_item_status_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The code identifying the discriminators for it work item status (of project, working package, specification)'),
it_work_item_status_change_tmsp TIMESTAMP NOT NULL
OPTIONS(description='A point in time, identified by a date and a time component.'),
risk_assessment_agreement_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Unique identifier (surrogate key) for risk assessment'),
risk_assessment_status_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The code identifying the discriminators for it work item status (of project, working package, specification)'),
related_solution_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the resource item. as an IT ressource. Key generation based on META table for party key space.'),
it_work_item_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description=' Denormalized Attribute- ID identifying the discriminators for it resource types in IT4You like Project, Task, Specification'),
it_work_item_nr STRING(250) NOT NULL
OPTIONS(description='Denormalized Attribute - Business Key / Natural Key -  Number for the project, task, specification in IT4 you'),
risk_assessment_nr STRING(250) NOT NULL OPTIONS(description='Natural Key/Business Key - SARA Business Key'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (it_work_item_resource_item_sid, it_work_item_status_id, it_work_item_status_change_tmsp) NOT ENFORCED
)
OPTIONS(description='Fact table - Transactional - Snapshot - containing NOT necessary every status change of a IT Work Item (PRJ, AP, SPEC) with its corresponding risk assessment (RA). Status of SARA dont\' cause new records in a table & are only additional - Source - IT4You Service Now.');