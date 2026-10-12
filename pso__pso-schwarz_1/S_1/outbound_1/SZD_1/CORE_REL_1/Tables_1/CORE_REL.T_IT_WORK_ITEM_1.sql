/* --------------------------------------------------------------------------------
   DDL for table: T_IT_WORK_ITEM_1
   generated from Powerdesigner on Dienstag, 30. April 2024 14:55:27
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_it_work_item_1 (
resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the resource item. as an IT ressource. Key generation based on META table for party key space.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
it_work_item_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Natural Key/Business Key - ID identifying the discriminators for it resource types in IT4You like Project, Task, Specification'),
parent_it_work_item_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the resource item. as an IT ressource. Key generation based on META table for party key space.'),
risk_assessment_agreement_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unique identifier (surrogate key)'),
related_solution_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the resource item. as an IT ressource. Key generation based on META table for party key space.'),
it_work_item_category_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - code identifying category of working packages'),
risk_assessment_relevant_fg BOOL NOT NULL
OPTIONS(description='Flag for identifying working package_1 (AP) that must be analyzed by a risk assessment prozess (SARA).TRUE - AP must be analyszed by  SARA .FALSE - AP must not be analyzed by SARA.            The filter used to identify the AP that must not be analyzed by  SARA.            APs that have no Solution attached (Field "No Solution available (Initiate SIP)" is True)            APs whose category is created from project, have a project reference and the project has the flag "SARA relevant" to True            APs whose category is created from project, and have no project reference'),
it_work_item_nr STRING(250) NOT NULL
OPTIONS(description='Business Key / Natural Key -  Number for the project, task, specification in IT4 you'),
it_work_item_name STRING(500) NOT NULL
OPTIONS(description='Descriptive Attribute - project, task, specification in IT4 you'),
it_work_item_creation_dt DATE NOT NULL
OPTIONS(description='Descriptive Attribute - Start date for project, task, specification in IT4 you'),
it_work_item_closing_dt DATE
OPTIONS(description='Descriptive Attribute - Closing date of project, specification in IT4 you'),
source_sys_nr STRING(100) NOT NULL
OPTIONS(description='Source system payload attribute - Technical Surrogate Key (surves as Natural Key) - additional technical system id for identification of tickets.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(250) NOT NULL
OPTIONS(description='The unique identifier of the batch load that has done the last modification to this record. (This can either be the initial insert, or an update operation at a later point in time.)'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (resource_item_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Entity - Entity is inherited from IT Resource & contains main items in the context of development/audit/risk assessment processes like Project (PRJ), Working Package_1 (AP), Specification (SPEC) etc. Start & closing dates are added as an excpetion due to transactional nature - Source - IT4You ServiceNow');