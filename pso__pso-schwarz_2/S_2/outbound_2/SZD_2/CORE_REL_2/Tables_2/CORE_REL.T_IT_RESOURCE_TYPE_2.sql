/* --------------------------------------------------------------------------------
   DDL for table: T_IT_RESOURCE_TYPE_2
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_it_resource_type_2 (
it_resource_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Natural Key/Business Key - The code identifying the discriminators for task configuration item_2 groups in IT4You'),
it_resource_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the discriminators for task configuration item_2 groups'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (it_resource_type_id) NOT ENFORCED
)
OPTIONS(description='Minor Entity - This minor entity defines the discriminators for Task CI (Configuration Item_2) Group. CI Group = IT Resource Type. Source - for ITPM Solution IT4You Service Now');