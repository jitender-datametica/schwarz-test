/* --------------------------------------------------------------------------------
   DDL for table: t_default_data_type
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_DEFAULT_DATA_TYPE (
   domain_name                         VARCHAR(100)    NOT NULL COMMENT 'The name of the domain.',
   technology_name                     VARCHAR(100)    NOT NULL COMMENT 'The name by which the technology is known, e.g. Teradata, AVRO, etc.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   data_type_name                      VARCHAR(100)    NOT NULL COMMENT 'The name for the data type, as defined for the given technology.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DEFAULT_DATA_TYPE PRIMARY KEY (technology_name, domain_name, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'In a physical model a domain is implemented by a data type. Depending on the technology, the domain concept defines a default data type for each domain. (Note that this data type may be overwritten for a particular column.)';
