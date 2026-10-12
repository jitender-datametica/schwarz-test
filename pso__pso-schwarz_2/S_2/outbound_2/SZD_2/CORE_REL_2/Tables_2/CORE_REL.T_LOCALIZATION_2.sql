/* --------------------------------------------------------------------------------
   DDL for table: T_LOCALIZATION_2
   generated from Powerdesigner on Dienstag, 30. April 2024 14:55:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_localization_2 (
localization_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Natural Key/Business Key - code identifying the discriminators for localization'),
localization_name STRING(100) NOT NULL
OPTIONS(description='A name for the discriminators for localization. E.g. for solution values like local, global, hybrid'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (localization_id) NOT ENFORCED
)
OPTIONS(description='Minor Entity - This minor entity defines the discriminators for solution localization e.g. local, global, hybrid - Source - IT4You Service Now');