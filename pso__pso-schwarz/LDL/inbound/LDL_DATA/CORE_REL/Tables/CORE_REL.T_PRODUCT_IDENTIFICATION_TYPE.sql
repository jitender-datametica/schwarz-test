/* --------------------------------------------------------------------------------
   DDL for table: t_product_identification_type
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:47
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_PRODUCT_IDENTIFICATION_TYPE (
   prod_ident_type_cd                  VARCHAR(20)     NOT NULL COMMENT 'The code identifying the type of number which identifies a product.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   prod_ident_type_descr               VARCHAR(250)    NOT NULL COMMENT 'A textual description for the type of number which identifies a product.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PRODUCT_IDENTIFICATION_TYPE PRIMARY KEY (prod_ident_type_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'A product may be identified by a variety of numbers. This minor entity defines the type of product number.';

