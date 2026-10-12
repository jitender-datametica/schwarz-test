--==============================================================
-- Table: T_DATA_ELEMENT_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DATA_ELEMENT_2
   generated from Powerdesigner on Freitag, 17. M�rz 2023 11:02:24
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_meta.t_data_element_2 (
data_elem_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the data element.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
data_struct_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the data structure.'),
data_struct_name STRING(100) NOT NULL
OPTIONS(description='The name of the data structure, which contains the data element.'),
data_elem_name STRING(100) NOT NULL
OPTIONS(description='The name of the data element, i.e. depending on the type of element, the attribute, column or field name.'),
data_elem_descr STRING(250) OPTIONS(description='The comment text for the data element.'),
data_elem_type_cd STRING(50) NOT NULL
OPTIONS(description='The code that identifies the subtype discriminator for data structures. It distinguishes between attributes, columns and fields.'),
frontend_attr_type_cd STRING(50) OPTIONS(description='The code identifying the kind of frontend attribute.'),
domain_name STRING(100) OPTIONS(description='The name of the domain.'),
nullable_fg BOOL
OPTIONS(description='If the flag is true, then the data object (attribute, column, etc.) does not always need to be filled, i.e. it may contain NULLs.'),
data_type_name STRING(100) OPTIONS(description='The name for the data type, as defined for the given technology.'),
precision_meas BIGNUMERIC(38,5)
OPTIONS(description='The precision of the data element (i.e. the number of decimal digits), if required by the data type. E.g. for a decimal (38,5) column, the precision is 5.'),
length_meas BIGNUMERIC(38,5)
OPTIONS(description='The length of the data element, if required by the data type. E.g. for a STRING columns, the length is 5.'),
parent_data_elem_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) of the parent data element of this element.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (data_elem_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A data element is a property within a data structure, so either an attribute, a column or a field. It is typically used to store attribute terms.');