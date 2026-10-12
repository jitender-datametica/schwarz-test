CREATE TABLE CORE.T_DIM_PRODUCT_ADDITIONAL_NUMBER_TYPE_1 (
   prod_add_nr_type_cd                 VARCHAR(5)      NOT NULL COMMENT 'The type of of industry and lidl product numbers assigned (gtin, ean_1, producer numbers etc )',
   prod_add_nr_type_descr              VARCHAR(250)    NOT NULL COMMENT 'A textual description of  lidl product assortment number in group language (German).',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_PRODUCT_ADDITIONAL_NUMBER_TYPE PRIMARY KEY (prod_add_nr_type_cd)
)
COMMENT = 'A list of industry and lidl product numbers assigned to a product and/or product variant ( including gtin, ean_1 and producer numbers).';
