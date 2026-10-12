/* --------------------------------------------------------------------------------
   DDL for table: t_stock_restriction_type_2
   generated from Powerdesigner on Montag, 8. Juli 2024 09:20:24
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_STOCK_RESTRICTION_TYPE_2 (
   stock_restriction_type_cd           VARCHAR(20)     NOT NULL COMMENT 'The code identifying the the kind of restriction regarding the stock which has to be kept for a product.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   stock_restriction_type_descr        VARCHAR(250)    NOT NULL COMMENT 'A textual description for the kind of restriction regarding the stock which has to be kept for a product.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_STOCK_RESTRICTION_TYPE PRIMARY KEY (stock_restriction_type_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the kind of restriction regarding the stock which has to be kept for a product.';
