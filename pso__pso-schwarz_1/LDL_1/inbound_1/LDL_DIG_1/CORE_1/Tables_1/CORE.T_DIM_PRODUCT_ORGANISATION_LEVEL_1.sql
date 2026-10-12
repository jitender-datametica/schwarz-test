CREATE TABLE CORE.T_DIM_PRODUCT_ORGANISATION_LEVEL_1 (
   PROD_ORG_LVL_NAME                   VARCHAR(50)     NOT NULL COMMENT 'The code for the product organisation level',
   PROD_ORG_LVL_DESCR                  VARCHAR(250)    COMMENT 'A textual description for the product organisation level',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_PRODUCT_ORGANISATION_ PRIMARY KEY (PROD_ORG_LVL_NAME)
       NOT ENFORCED
)
COMMENT = 'The Organisation level is a mapped field for every category in the GS1 article categorization system on level 4. Every Brickcode has a mapped Organisation level, which can be compared to the old Shop categorie 1, but now based first on the Brickcode structure. The Organisation level is a mapping to transfer the GS1 article categorization system to the structures of Lidl Digital.';
