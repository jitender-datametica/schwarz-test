/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REL_PROMOTION_SALES_CLUSTER_WEEK_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 26. Juli 2022 14:12:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_REL_PROMOTION_SALES_CLUSTER_WEEK_2 (
   PROMO_SALE_CLUSTER_CD               NUMBER          NOT NULL COMMENT 'A code for aggregation of sales_2 orders assigned to a promotion based on the customer order date',
   WEEK_NR                             NUMBER          NOT NULL COMMENT 'The week number connected to promo sale cluster code e.g cluster 1,2,3 are part of week 1',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_REL_PROMOTION_SALES_CLUSTER_WEEK PRIMARY KEY (PROMO_SALE_CLUSTER_CD, WEEK_NR) NOT ENFORCED
 )  COMMENT= 'The relation table for the promotion sales_2 cluster to the corresponding week';
