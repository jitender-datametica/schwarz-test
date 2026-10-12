/* --------------------------------------------------------------------------------
   DDL for table: t_dim_product_variant_status_1
   generated from Powerdesigner on Montag, 8. Juli 2024 09:22:20
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_DIM.T_DIM_PRODUCT_VARIANT_STATUS_1 (
   prod_variant_status_cd              VARCHAR(20)     NOT NULL COMMENT 'A code that defines the lifecycle status_1 of a product variant, i.e. of a sales_1 variant or a logistc variant.',
   prod_variant_status_descr           VARCHAR(250)    NOT NULL COMMENT 'A textual description for the status_1 code of a product variant. (Description in group language, i.e. in German)',
   prod_variant_status_descr_de        VARCHAR(250)    COMMENT 'A textual description for the status_1 code of a product variant. (Description in German)',
   prod_variant_status_descr_en        VARCHAR(250)    COMMENT 'A textual description for the status_1 code of a product variant. (Description in English)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DIM_PRODUCT_VARIANT_STATUS PRIMARY KEY (prod_variant_status_cd) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the status_1 codes for product variants, i.e. sales_1 variants and logistic variants.';
