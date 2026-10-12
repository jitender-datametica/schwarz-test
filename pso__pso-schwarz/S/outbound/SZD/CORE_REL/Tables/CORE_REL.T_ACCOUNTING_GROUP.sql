/* --------------------------------------------------------------------------------
   DDL for table: T_ACCOUNTING_GROUP
   generated from Powerdesigner on Montag, 11. November 2024 08:57:39
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_accounting_group (
accounting_group_cd STRING(50) NOT NULL OPTIONS(description='The code identifying the accounting group.'),
accounting_group_name STRING(100) NOT NULL OPTIONS(description='The name of the accounting group.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (accounting_group_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - Defines the accounting groups for positions of an internal sales receipt. - Source - Lexis');