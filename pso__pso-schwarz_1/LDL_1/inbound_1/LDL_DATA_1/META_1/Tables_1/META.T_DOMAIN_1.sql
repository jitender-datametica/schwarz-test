/* --------------------------------------------------------------------------------
   DDL for table: t_domain_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_DOMAIN_1 (
   domain_name                         VARCHAR(100)    NOT NULL COMMENT 'The name of the domain.',
   domain_descr                        VARCHAR(250)    COMMENT 'A textual definition of the domain describing its purpose and how it should be used.',
   domain_family_name                  VARCHAR(100)    NOT NULL COMMENT 'The name for the group of domains. E.g. Numeric, Code, Identifier, ...',
   logical_suffix_name                 VARCHAR(100)    COMMENT 'In case domain get considered in the naming standard, this is the suffix used for logical models.',
   physical_suffix_name                VARCHAR(100)    COMMENT 'In case domain get considered in the naming standard, this is the suffix used for physical models.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DOMAIN PRIMARY KEY (domain_name) NOT ENFORCED
 )  COMMENT= 'A domain describes the character of a data element, e.g. of an attribute in an entity. It is not only an abstract data type, but also defines the purpose and the format of the column.';
