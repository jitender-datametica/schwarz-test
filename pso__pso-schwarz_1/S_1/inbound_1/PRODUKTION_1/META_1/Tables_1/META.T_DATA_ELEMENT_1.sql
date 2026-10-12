--==============================================================
-- Table: T_DATA_ELEMENT_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DATA_ELEMENT_1
   generated from Powerdesigner on Freitag, 17. M�rz 2023 11:02:24
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_DATA_ELEMENT_1 (
   DATA_ELEM_SID                       NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier (surrogate key) of the data element.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   DATA_STRUCT_SID                     NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier (surrogate key) of the data structure.',
   DATA_STRUCT_NAME                    VARCHAR(100)    NOT NULL COMMENT 'The name of the data structure, which contains the data element.',
   DATA_ELEM_NAME                      VARCHAR(100)    NOT NULL COMMENT 'The name of the data element, i.e. depending on the type of element, the attribute, column or field name.',
   DATA_ELEM_DESCR                     VARCHAR(250)    COMMENT 'The comment text for the data element.',
   DATA_ELEM_TYPE_CD                   VARCHAR(50)     NOT NULL COMMENT 'The code that identifies the subtype discriminator for data structures. It distinguishes between attributes, columns and fields.',
   FRONTEND_ATTR_TYPE_CD               VARCHAR(50)     COMMENT 'The code identifying the kind of frontend attribute.',
   DOMAIN_NAME                         VARCHAR(100)    COMMENT 'The name of the domain.',
   NULLABLE_FG                         BOOLEAN         COMMENT 'If the flag is true, then the data object (attribute, column, etc.) does not always need to be filled, i.e. it may contain NULLs.',
   DATA_TYPE_NAME                      VARCHAR(100)    COMMENT 'The name for the data type, as defined for the given technology.',
   PRECISION_MEAS                      NUMBER(38, 5)   COMMENT 'The precision of the data element (i.e. the number of decimal digits), if required by the data type. E.g. for a decimal (38,5) column, the precision is 5.',
   LENGTH_MEAS                         NUMBER(38, 5)   COMMENT 'The length of the data element, if required by the data type. E.g. for a char(5) columns, the length is 5.',
   PARENT_DATA_ELEM_SID                NUMBER(38,0)    COMMENT 'The unique identifier (surrogate key) of the parent data element of this element.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   DWH_NODE_CD                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DATA_ELEMENT PRIMARY KEY (DATA_ELEM_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'A data element is a property within a data structure, so either an attribute, a column or a field. It is typically used to store attribute terms.';

