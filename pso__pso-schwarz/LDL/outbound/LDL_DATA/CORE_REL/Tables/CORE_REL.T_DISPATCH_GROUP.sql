/* --------------------------------------------------------------------------------
   DDL for table: t_dispatch_group
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:43
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_dispatch_group (
dispatch_grp_nr STRING(20) NOT NULL
OPTIONS(description='The number which identifies the dispatch group, i.e. the group of products which are handled together in the logistics process.'),
int_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal organization.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
dispatch_grp_descr STRING(250) NOT NULL OPTIONS(description='A textual description for the dispatch group.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (dispatch_grp_nr, int_org_sid, lang_cd) NOT ENFORCED
)
OPTIONS(description='A dispatch group defines a group of products which are handled together in the logistics process.');