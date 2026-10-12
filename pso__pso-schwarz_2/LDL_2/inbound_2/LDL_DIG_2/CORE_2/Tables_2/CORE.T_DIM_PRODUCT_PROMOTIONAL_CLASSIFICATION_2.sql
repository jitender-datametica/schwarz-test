CREATE TABLE CORE.T_DIM_PRODUCT_PROMOTIONAL_CLASSIFICATION_2 (
   prod_promo_class_cd                 VARCHAR(5)      NOT NULL COMMENT 'The code for indicating if product  is a part of a promotion or main assortment.',
   prod_promo_class_descr              VARCHAR(250)    NOT NULL COMMENT 'A textual description for the product_promotional_classification in group language (German).',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_PRODUCT_PROMOTIONAL_CLASSIFICATION PRIMARY KEY (prod_promo_class_cd))
COMMENT = 'This minor dimension defines if a product is a part of a promotion or main assortment';
