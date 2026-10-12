CREATE TABLE CORE.T_DIM_PRODUCT_STOCK_AGE_CLUSTER_1 (
   PROD_STOCK_AGE_CLUSTER_CD           VARCHAR(5)      NOT NULL COMMENT 'A code for aggregation of product stock into age clusters to define how long products have been stored in our warehouse.',
   PROD_STOCK_AGE_CLUSTER_DESCR        VARCHAR(250)    COMMENT 'A description for aggregation of product stock into age clusters.',
   CLUSTER_FIRST_DAY                   NUMBER          COMMENT 'Minimum day of the cluster',
   CLUSTER_LAST_DAY                    NUMBER          COMMENT 'Maximum day of the cluster',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_PRODUCT_STOCK_AGE_CLUSTER PRIMARY KEY (PROD_STOCK_AGE_CLUSTER_CD) NOT ENFORCED
 )  COMMENT= 'A minor dimension that defines age cluster buckets.The age clusters are defining how long products have been stored in our warehouse. Based on this clusters the departments are able to tell for how long products are laying in our warehouse and whats the total amount of products in a cluster.';
