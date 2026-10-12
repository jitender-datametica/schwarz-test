/* --------------------------------------------------------------------------------
   DDL for table: t_domain_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_meta.t_domain_1 (
domain_name STRING(100) NOT NULL OPTIONS(description='The name of the domain.'),
domain_descr STRING(250)
OPTIONS(description='A textual definition of the domain describing its purpose and how it should be used.'),
domain_family_name STRING(100) NOT NULL
OPTIONS(description='The name for the group of domains. E.g. Numeric, Code, Identifier, ...'),
logical_suffix_name STRING(100)
OPTIONS(description='In case domain get considered in the naming standard, this is the suffix used for logical models.'),
physical_suffix_name STRING(100)
OPTIONS(description='In case domain get considered in the naming standard, this is the suffix used for physical models.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (domain_name) NOT ENFORCED
)
OPTIONS(description='A domain describes the character of a data element, e.g. of an attribute in an entity. It is not only an abstract data type, but also defines the purpose and the format of the column.');