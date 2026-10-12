CREATE TABLE CORE.T_DIM_PROMOTION_SALES_CLUSTER_2 (
   PROMO_SALE_CLUSTER_CD               NUMBER          NOT NULL COMMENT 'A code for aggregation of sales_2 orders assigned to a promotion based on the customer order date',
   PROMO_SALE_CLUSTER_DESCR            VARCHAR(250)    COMMENT 'A description for aggregation of sales_2 orders assigned to a promotion based on the customer order date',
   LAST_WEEK_NR                        NUMBER          COMMENT 'The last week number connected to promo sale cluster code e.g cluster 1,2,3 are part of week 1',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_PROMOTION_SALES_CLUSTER PRIMARY KEY (PROMO_SALE_CLUSTER_CD) NOT ENFORCED
 )  COMMENT= 'A minor dimension that defines clustering for sales_2 analysis during promotion';