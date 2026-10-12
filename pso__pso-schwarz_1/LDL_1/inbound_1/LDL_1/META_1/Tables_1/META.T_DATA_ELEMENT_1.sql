/* --------------------------------------------------------------------------------
   DDL for table: t_data_element_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_DATA_ELEMENT_1 (
   data_elem_sid                       NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the data element.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   data_struct_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the data structure.',
   data_struct_name                    VARCHAR(100)    NOT NULL COMMENT 'The name of the data structure, which contains the data element.',
   data_elem_name                      VARCHAR(100)    NOT NULL COMMENT 'The name of the data element, i.e. depending on the type of element, the attribute, column or field name.',
   data_elem_descr                     VARCHAR(250)    COMMENT 'The comment text for the data element.',
   data_elem_type_cd                   VARCHAR(20)     NOT NULL COMMENT 'The code that identifies the subtype discriminator for data structures. It distinguishes between attributes, columns and fields.',
   frontend_attr_type_cd               VARCHAR(20)     COMMENT 'The code identifying the kind of frontend attribute.',
   domain_name                         VARCHAR(100)    COMMENT 'The name of the domain.',
   nullable_fg                         BOOLEAN         COMMENT 'If the flag is true, then the data object (attribute, column, etc.) does not always need to be filled, i.e. it may contain NULLs.',
   data_type_name                      VARCHAR(100)    COMMENT 'The name for the data type, as defined for the given technology.',
   precision_meas                      NUMBER(38, 0)   COMMENT 'The precision of the data element (i.e. the number of decimal digits), if required by the data type. E.g. for a decimal (38,5) column, the precision is 5.',
   length_meas                         NUMBER(38, 0)   COMMENT 'The length of the data element, if required by the data type. E.g. for a char(5) columns, the length is 5.',
   parent_data_elem_sid                NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) of the parent data element of this element.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DATA_ELEMENT PRIMARY KEY (data_elem_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'A data element is a property within a data structure, so either an attribute, a column or a field. It is typically used to store attribute terms.';
