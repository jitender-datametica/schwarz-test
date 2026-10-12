/* --------------------------------------------------------------------------------
   DDL for table: t_product_status_category_1
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:44
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_PRODUCT_STATUS_CATEGORY_1 (
   prod_status_categ_cd                VARCHAR(20)     NOT NULL COMMENT 'The code identifying the kind of status_1 lifecycle for products.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   prod_status_categ_descr             VARCHAR(250)    NOT NULL COMMENT 'A textual description for the kind of status_1 lifecycle for products.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PRODUCT_STATUS_CATEGORY PRIMARY KEY (prod_status_categ_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the type of status_1 lifecycle for products. E.g. the buying status_1 and the workflow status_1 for non-food items or the status_1 in the retail system.';

