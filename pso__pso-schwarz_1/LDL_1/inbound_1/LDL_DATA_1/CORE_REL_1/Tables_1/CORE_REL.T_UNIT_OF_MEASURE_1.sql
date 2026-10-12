CREATE TABLE core_rel.T_UNIT_OF_MEASURE_1 (
   uom_cd                              VARCHAR(20)     NOT NULL COMMENT 'The code identifying the unit_1 of measure.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   uom_name                            VARCHAR(100)    NOT NULL COMMENT 'The name for the unit_1 of measure.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_UNIT_OF_MEASURE PRIMARY KEY (uom_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'The unit_1 in which a quantity is expressed. This includes mostly physical units, such as kilogram, meters or seconds, but also units such as slices or pieces.';
