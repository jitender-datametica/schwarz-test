/* --------------------------------------------------------------------------------
   DDL for table: t_dim_local_logistic_variant_2
   generated from Powerdesigner on Montag, 20. November 2023 13:23:44
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_DIM.T_DIM_LOCAL_LOGISTIC_VARIANT_2 (
   logistic_variant_sid                NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for a logistic variant of a product.',
   country_org_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the country_2 organization.',
   country_org_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code of the business country_2 for which this country_2 organization is responsible. (The business country_2 is not identical to a political country.)',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   local_logistic_variant_nr           VARCHAR(20)     COMMENT 'The number which identifies this logistic variant within the given market / internal organization.',
   local_logistic_variant_name         VARCHAR(500)    NOT NULL COMMENT 'The name of the logistic variant for the given market / internal organization.',
   prod_variant_status_cd              VARCHAR(20)     NOT NULL COMMENT 'A code that defines the lifecycle status_2 of the logistic variant,',
   prod_variant_status_descr           VARCHAR(250)    NOT NULL COMMENT 'A textual description for the status_2 code of a product variant in group language, i.e. in German.',
   prod_sid                            NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the product, which is the base for this logistic variant.',
   prod_nr                             VARCHAR(20)     COMMENT 'The number which (globally) identifies the product which is the base for this logistic variant, within the organization. (Note that the product number is unique for a certain point in time, but may be re_2-used later on.)',
   prod_name                           VARCHAR(250)    NOT NULL COMMENT 'The name of the global product, which is the base for this logistic variant.',
   item_fam_sid                        NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the item_2 family, which contains this logistic variant.',
   item_fam_nr                         VARCHAR(100)    COMMENT 'The number by which the related item_2 family is known to business.',
   item_fam_name                       VARCHAR(100)    NOT NULL COMMENT 'The name of the related item_2 family in group language, i.e. in German.',
   sub_item_grp_sid                    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the sub item_2 group, which contains this logistic variant.',
   sub_item_grp_nr                     VARCHAR(100)    COMMENT 'The number by which the related sub item_2 group is known to business.',
   sub_item_grp_name                   VARCHAR(100)    NOT NULL COMMENT 'The name of the related sub item_2 group in group language, i.e. in German.',
   int_item_grp_sid                    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the international item_2 group, which contains this logistic variant.',
   int_item_grp_nr                     VARCHAR(100)    COMMENT 'The number by which the related international item_2 group is known to business.',
   int_item_grp_name                   VARCHAR(100)    NOT NULL COMMENT 'The name of the related international item_2 group in group language, i.e. in German.',
   pillar_sid                          NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the pillar, which contains this logistic variant.',
   pillar_nr                           VARCHAR(100)    COMMENT 'The number by which the related pillar is known to business.',
   pillar_name                         VARCHAR(100)    NOT NULL COMMENT 'The name of the related pillar in group language, i.e. in German.',
   main_pillar_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the main pillar, which contains this logistic variant.',
   main_pillar_nr                      VARCHAR(100)    COMMENT 'The number by which the related main pillar is known to business.',
   main_pillar_name                    VARCHAR(100)    NOT NULL COMMENT 'The name of the related main pillar in group language, i.e. in German.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DIM_LOCAL_LOGISTIC_VARIANT PRIMARY KEY (logistic_variant_sid, country_org_sid, dwh_valid_from_tmsp) NOT ENFORCED
)  COMMENT= 'This dimension tracks the local properties of a logistic variant, as they are defined by a country_2 organization.';
