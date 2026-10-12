CREATE TABLE CORE.T_DIM_PRODUCT_STORAGE_CONDITION  (
   prod_storage_cond_cd                VARCHAR(5)      NOT NULL COMMENT 'The code for the indicating the storage conditions for a product  (Z1, 01, etc)',
   prod_storage_cond_descr             VARCHAR(250)    NOT NULL COMMENT 'A textual description for the storage conditions in group language (German).',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_PRODUCT_STORAGE_CONDITION PRIMARY KEY (prod_storage_cond_cd)
)
COMMENT = 'This minor dimension defines the storage conditions for a product  ';
