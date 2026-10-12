/* --------------------------------------------------------------------------------
   DDL for table: t_packing_type
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:43
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_PACKING_TYPE (
   packing_type_cd                     VARCHAR(20)     NOT NULL COMMENT 'The code identifying the way, how a product is packed.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   packing_type_name                   VARCHAR(100)    NOT NULL COMMENT 'The name for the way, how a product is packed.',
   packing_type_descr                  VARCHAR(250)    COMMENT 'A textual description for the way, how a product is packed.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PACKING_TYPE PRIMARY KEY (packing_type_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the way, how a product is packed, e.g. in a can, a bottle, etc.';

