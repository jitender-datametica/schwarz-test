CREATE TABLE CORE.T_DIM_PRODUCT_DANGEROUS_GOOD_CLASSIFICATION_1 (
   prod_dang_good_class_cd             VARCHAR(5)      NOT NULL COMMENT 'The code for the indicating if product is a dangerous good  ( if is  a dangerous good and if additional papers are requried).',
   prod_dang_good_class_descr          VARCHAR(250)    NOT NULL COMMENT 'A textual description for the dangerous good classification in group language (German).',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_PRODUCT_DANGEROUS_GOOD PRIMARY KEY (prod_dang_good_class_cd)
)
COMMENT = 'This minor dimension defines dangerous good profile of a product ( if is  a dangerous good and if additional papers are requried).';
