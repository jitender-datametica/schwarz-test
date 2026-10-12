/* --------------------------------------------------------------------------------
   DDL for table: t_product_tax_1
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:47
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_PRODUCT_TAX_1 (
   prod_sid                            NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the product.',
   geo_area_sid                        NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the geographical area to which the tax class applies.',
   tax_class_cd                        VARCHAR(20)     NOT NULL COMMENT 'The code for the tax class, e.g. Reduced VAT Rate.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PRODUCT_TAX PRIMARY KEY (tax_class_cd, geo_area_sid, prod_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'This entity tracks the tax classes which are applicable for a product, depending on the geographical area - e.g. the VAT category per country.';

