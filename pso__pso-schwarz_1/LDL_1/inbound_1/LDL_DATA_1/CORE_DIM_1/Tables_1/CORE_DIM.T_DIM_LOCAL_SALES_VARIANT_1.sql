/* --------------------------------------------------------------------------------
   DDL for table: t_dim_local_sales_variant_1
   generated from Powerdesigner on Montag, 20. November 2023 13:22:42
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_DIM.T_DIM_LOCAL_SALES_VARIANT_1 (
   sales_variant_sid                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the sales_1 variant of a product.',
   country_org_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the country_1 organization.',
   country_org_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code of the business country_1 for which this country_1 organization is responsible. (The business country_1 is not identical to a political country.)',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   local_sales_variant_nr              VARCHAR(100)    COMMENT 'The number which identifies the sales_1 variant within the given market / internal organization.',
   local_sales_variant_name            VARCHAR(500)    COMMENT 'The name of the sales_1 variant for the given market / internal organization.',
   prod_variant_status_cd              VARCHAR(20)     NOT NULL COMMENT 'A code that defines the lifecycle status_1 of a product variant, i.e. of a sales_1 variant or a logistc variant.',
   prod_variant_status_descr           VARCHAR(250)    NOT NULL COMMENT 'A textual description for the status_1 code of a product variant in group language, i.e. in German.',
   prod_sid                            NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the product.',
   prod_nr                             VARCHAR(20)     COMMENT 'The number which (globally) identifies the product which is the base for this sales_1 variant, within the organization. (Note that the product number is unique for a certain point in time, but may be re_1-used later on.)',
   prod_name                           VARCHAR(250)    NOT NULL COMMENT 'The name of the global product, which is the base for this sales_1 variant.',
   item_fam_sid                        NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the related item_1 family.',
   item_fam_nr                         VARCHAR(100)    COMMENT 'The number by which the related item_1 family is known to business.',
   item_fam_name                       VARCHAR(100)    NOT NULL COMMENT 'The name of the related item_1 family in group language, i.e. in German.',
   sub_item_grp_sid                    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the related sub item_1 group',
   sub_item_grp_nr                     VARCHAR(100)    COMMENT 'The number by which the sub item_1 group is known to business.',
   sub_item_grp_name                   VARCHAR(100)    NOT NULL COMMENT 'The name of the related sub item_1 group in group language, i.e. in German.',
   int_item_grp_sid                    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier [surrogate key] for the related international item_1 group.',
   int_item_grp_nr                     VARCHAR(100)    COMMENT 'The number by which the related international item_1 group is known to business.',
   int_item_grp_name                   VARCHAR(100)    NOT NULL COMMENT 'The name of the related international item_1 group in group language, i.e. in German.',
   pillar_sid                          NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the related pillar.',
   pillar_nr                           VARCHAR(100)    COMMENT 'The number by which the related pillar is known to business.',
   pillar_name                         VARCHAR(100)    NOT NULL COMMENT 'The name of the related pillar in group language, i.e. in German.',
   main_pillar_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the related main pillar.',
   main_pillar_nr                      VARCHAR(100)    COMMENT 'The number by which the related main pillar is known to business.',
   main_pillar_name                    VARCHAR(100)    NOT NULL COMMENT 'The name of the related main pillar in group language, i.e. in German.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DIM_LOCAL_SALES_VARIANT PRIMARY KEY (sales_variant_sid, dwh_valid_from_tmsp, country_org_sid) NOT ENFORCED
)  COMMENT= 'This dimension tracks the local properties of each sales_1 variant, as they are defined by a country_1 organization.';
