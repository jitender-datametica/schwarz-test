CREATE TABLE CORE.t_dim_delivery_source_type (
   delivery_src_type_cd                VARCHAR(5)      NOT NULL COMMENT 'The code for source location of product from where it is delivered i.e. from supplier or warehouse directly',
   delivery_src_type_descr             VARCHAR(250)    NOT NULL COMMENT 'The description for source location of product from where it is delivered i.e. from supplier or warehouse directly',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_DELIVERY_SOURCE_TYPE PRIMARY KEY (DELIVERY_SRC_TYPE_CD)
   )COMMENT = 'This minor dimension defines from where product is delivered (Warehouse or Supplier direcly)';
