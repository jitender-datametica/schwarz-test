CREATE TABLE ETL_PROCESS.T_ETL_GS1_CODE (
   GS1_CAT_CD                          VARCHAR(36)     NOT NULL,
   GS1_INTERNAL_CD                     VARCHAR(20),
   GS1_TYPE_CD                         VARCHAR(6),
   GS1_GROUP_CD                        VARCHAR(20),
   PROD_ORG_LVL_NAME                   VARCHAR(100)    COMMENT 'The Organisation level is a mapped field for every category in the GS1 article categorization system on level 4. Every Brickcode has a mapped Organisation level, which can be compared to the old Shop categorie 1, but now based first on the Brickcode structure. The Organisation level is a mapping to transfer the GS1 article categorization system to the structures of Lidl Digital.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_GS1_CODE PRIMARY KEY (GS1_CAT_CD)
       NOT ENFORCED
)
COMMENT = 'This ETL table to support brickcode .';