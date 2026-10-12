CREATE TABLE CORE.T_DIM_PRODUCT_CATEGORY_PPE_1 (
   PROD_CATEGORY_PPE_NAME              VARCHAR(250)    NOT NULL COMMENT 'The name of the PPE category which the product has been automatically assigned (Profilierung / Pflicht / Ergänzung).',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_DIM_PRODUCT_CATEGORY_PPE PRIMARY KEY (PROD_CATEGORY_PPE_NAME) NOT ENFORCED 
)  COMMENT = 'A categorization of products for the oline shop in all countries, where products can be assigned to one of three categories: Profilierung, Pflicht, or Ergänzung. This categorization is not obligatory.';
