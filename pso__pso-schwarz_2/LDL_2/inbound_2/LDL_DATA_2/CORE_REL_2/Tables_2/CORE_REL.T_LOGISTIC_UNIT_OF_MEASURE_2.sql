/* --------------------------------------------------------------------------------
   DDL for table: t_logistic_unit_of_measure_2
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:46
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LOGISTIC_UNIT_OF_MEASURE_2 (
   logistic_uom_cd                     VARCHAR(20)     NOT NULL COMMENT 'The code identifying the logistic unit_2 of measure. (e.g. palettes, boxes, pieces or layers on a palette)',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   logistic_uom_descr                  VARCHAR(250)    NOT NULL COMMENT 'A textual description for the logistic unit_2 of measure.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_LOGISTIC_UNIT_OF_MEASURE PRIMARY KEY (logistic_uom_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'For logistics, quantities are expressed as numbers of palettes, boxes, pieces or layers on a palette. The logistic unit_2 of measure defines these units.';

