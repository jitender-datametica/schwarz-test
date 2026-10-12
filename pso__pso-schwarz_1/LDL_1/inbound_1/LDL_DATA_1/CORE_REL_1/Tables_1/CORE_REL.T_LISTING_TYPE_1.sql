/* --------------------------------------------------------------------------------
   DDL for table: t_listing_type_1
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:44
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LISTING_TYPE_1 (
   list_type_cd                        VARCHAR(20)     NOT NULL COMMENT 'The code identifying the listing type, e.g. regular assortment, seasonal products, promotional items, etc.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   list_type_descr                     VARCHAR(250)    NOT NULL COMMENT 'A textual description for the listing type. E.g. regular assortment, seasonal products, promotional items, etc.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_LISTING_TYPE PRIMARY KEY (list_type_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'The listing types distinguishes the regular assortment from seasonal products, promotional items, etc.';

