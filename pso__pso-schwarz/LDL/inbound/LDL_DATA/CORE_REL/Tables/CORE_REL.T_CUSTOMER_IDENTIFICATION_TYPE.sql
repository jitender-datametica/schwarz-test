/* --------------------------------------------------------------------------------
   DDL for table: t_customer_identification_type
   generated from Powerdesigner on Mittwoch, 25. Januar 2023 20:59:23
*/ --------------------------------------------------------------------------------

CREATE TABLE core_rel.T_CUSTOMER_IDENTIFICATION_TYPE (
   cust_ident_type_cd                  VARCHAR(20)     NOT NULL COMMENT 'The code identifying the way how the customer identifies himself in the store, e.g. by his loyalty card.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   cust_ident_type_descr               VARCHAR(250)    NOT NULL COMMENT 'A textual description for the way how the customer identifies himself in the store, e.g. by his loyalty card.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_CUSTOMER_IDENTIFICATION_TYPE PRIMARY KEY (cust_ident_type_cd, lang_cd) NOT ENFORCED
)  COMMENT= 'This minor entity defines the way how the customer identifies himself in the store, e.g. by his loyalty card.';