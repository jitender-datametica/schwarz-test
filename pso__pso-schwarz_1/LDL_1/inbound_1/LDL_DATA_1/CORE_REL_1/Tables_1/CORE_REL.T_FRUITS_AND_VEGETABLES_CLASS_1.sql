/* --------------------------------------------------------------------------------
   DDL for table: t_fruits_and_vegetables_class_1
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:43
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_FRUITS_AND_VEGETABLES_CLASS_1 (
   fruits_and_vegetables_class_cd      VARCHAR(20)     NOT NULL COMMENT 'The code identifying the(quality) class for fruits and vegetables.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   fruits_and_vegetables_class_descr   VARCHAR(250)    NOT NULL COMMENT 'A textual description for the (quality) class for fruits and vegetables.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_FRUITS_AND_VEGETABLES_CLASS PRIMARY KEY (fruits_and_vegetables_class_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the (quality classes for fruits and vegetables.';

