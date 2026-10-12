/* --------------------------------------------------------------------------------
   DDL for table: t_product_identification_2
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:47
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_PRODUCT_IDENTIFICATION_2 (
   prod_sid                            NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the product.',
   int_org_sid                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization.',
   prod_ident_type_cd                  VARCHAR(20)     NOT NULL COMMENT 'The code identifying the type of number which identifies a product.',
   prod_ident_nr                       VARCHAR(20)     NOT NULL COMMENT 'The number which identifies the product.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PRODUCT_IDENTIFICATION PRIMARY KEY (prod_sid, int_org_sid, prod_ident_type_cd, prod_ident_nr, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'This entity tracks additional numbers which are used to identify the product. The kind of number is defined by the Product Identification Type Code. A product may be identified by multiple numbers, even of the same type. E.g. due to internal restrictions, the retail system may create several numbers for the same product.';

