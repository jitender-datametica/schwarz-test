CREATE TABLE CORE.T_DIM_PRODUCT_MATERIAL_TYPE_2 (
   prod_material_type_cd               VARCHAR(5)      NOT NULL COMMENT 'The code for the indicating the material type code for a product ( a regular one , a digital one , etc)',
   prod_material_type_descr            VARCHAR(250)    NOT NULL COMMENT 'A textual description for the material type code in group language (German).',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_PRODUCT_MATERIAL_TYPE PRIMARY KEY (prod_material_type_cd)
)
COMMENT = 'This minor dimension defines the material type for a product ( a regular one , a digital one , etc)';