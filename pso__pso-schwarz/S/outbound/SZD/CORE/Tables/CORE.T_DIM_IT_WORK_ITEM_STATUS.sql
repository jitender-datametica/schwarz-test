/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_IT_WORK_ITEM_STATUS
   generated from Powerdesigner on Dienstag, 30. April 2024 14:55:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_it_work_item_status (
it_work_item_status_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The code identifying the discriminators for it work item status (of project, working package, specification)'),
it_work_item_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The code identifying the discriminators for it work item types (project, working package, specification)'),
it_work_item_status_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The code identifying the it work item status (of project, working package, specification)'),
it_work_item_status_name STRING(100) NOT NULL
OPTIONS(description='Descriptive Attribute - A name for it work item status  (of project, working package, specification)'),
it_work_item_status_name_de STRING(100) NOT NULL
OPTIONS(description='A textual description for the discriminators for it work item status. Language german'),
it_work_item_status_name_en STRING(100) NOT NULL
OPTIONS(description='A textual description for the discriminators for it work item status. Language english'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BYTES storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (it_work_item_status_id) NOT ENFORCED
)
OPTIONS(description='Minor Dimensio - defines the discriminators for it_work_item status. Possible status: Open / Work in progress / Waiting - wait for external oder wait for enduser / Comped / Closed. - Source - IT4You Service Now');