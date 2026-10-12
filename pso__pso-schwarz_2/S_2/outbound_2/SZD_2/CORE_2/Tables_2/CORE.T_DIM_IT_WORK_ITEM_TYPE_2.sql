/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_IT_WORK_ITEM_TYPE_2
   generated from Powerdesigner on Dienstag, 30. April 2024 14:55:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_it_work_item_type_2 (
it_work_item_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Natural Key/Business Key - ID identifying the discriminators for it resource types in IT4You like Project, Task, Specification'),
it_work_item_type_name STRING(100) NOT NULL
OPTIONS(description='A name for the discriminators for it resource types in IT4You'),
synonym_it_work_item_type_name STRING(100) NOT NULL
OPTIONS(description='Descriptive Attribute - The synonym name of discriminators for it resource types in IT4You.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (it_work_item_type_id) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - This minor entity defines the discriminators for IT Work Items e.g. Project, Task, Specification - Source - ITPM Solution IT4You Service Now');