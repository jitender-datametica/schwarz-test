/* --------------------------------------------------------------------------------
   DDL for table: t_product_return_reason_2
   generated from Powerdesigner on Mittwoch, 22. Februar 2023 17:33:59
*/ --------------------------------------------------------------------------------

CREATE TABLE core_rel.T_PRODUCT_RETURN_REASON_2 (
   prod_return_reason_sid              NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the reasons why a product was returend to the store.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   prod_return_reason_descr            VARCHAR(250)    NOT NULL COMMENT 'A textual description for the reasons why a product was returend to the store.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PRODUCT_RETURN_REASON PRIMARY KEY (prod_return_reason_sid, lang_cd) NOT ENFORCED
)  COMMENT= 'This minor entity defines the reasons why a product was returend to the store.';