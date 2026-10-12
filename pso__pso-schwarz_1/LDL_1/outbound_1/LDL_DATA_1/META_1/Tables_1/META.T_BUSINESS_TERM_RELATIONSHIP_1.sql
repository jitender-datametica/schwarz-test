/* --------------------------------------------------------------------------------
   DDL for table: t_business_term_relationship_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_meta.t_business_term_relationship_1 (
bus_term_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the object term.'),
rel_bus_term_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related object term.'),
bus_term_rel_name STRING(100) NOT NULL
OPTIONS(description='A verb describing the way how the two business terms are related with each other. E.g. "works" for a relationship describing that an employee_1 works in a store. Ideally, the sequence <Business Term> <Business Term Relation Name> <Related Business Term> should form a sentence.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (rel_bus_term_sid, bus_term_sid, bus_term_rel_name, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Business terms may be related to each other, E.g. a supplier_1 provides certain products or an employee_1 works in a department. This entity only contains two-way relations. Due to a limitation in Ab Initio MHub a separate object term needs to be created, in case three or more business terms form the relation.');