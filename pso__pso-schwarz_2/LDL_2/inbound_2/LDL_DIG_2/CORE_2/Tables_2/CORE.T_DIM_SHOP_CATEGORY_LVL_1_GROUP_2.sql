CREATE TABLE CORE.T_DIM_SHOP_CATEGORY_LVL_1_GROUP_2 (
   SHOP_CATEGORY_LVL_1_GROUP_NAME      VARCHAR(40)     NOT NULL COMMENT 'The code for the product size type (''Kleines Kleinteil'', ''Großteil''	, etc)',
   SHOP_CATEGORY_LVL_1_GROUP_DESCR     VARCHAR(250)    NOT NULL COMMENT 'A textual description for the  product  size type  in group language (German).',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_SHOP_CATEGORY_LVL_1_GROUP PRIMARY KEY (SHOP_CATEGORY_LVL_1_GROUP_NAME)
       NOT ENFORCED
)
COMMENT = 'The additional grouping derived from shop category level 1  (''Bücher & Medien'', ''Gesundheit & Pflege'', ''Lebensmittel & Drogerie'' , ''Tierwelt'', etc)';
