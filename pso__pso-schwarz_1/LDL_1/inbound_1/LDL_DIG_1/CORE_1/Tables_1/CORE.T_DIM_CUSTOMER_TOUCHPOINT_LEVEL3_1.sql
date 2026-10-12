CREATE TABLE CORE.T_DIM_CUSTOMER_TOUCHPOINT_LEVEL3_1 (
   cust_touchpoint_lvl3_id             NUMBER          NOT NULL COMMENT 'The identifier for customer touchpoint at hierarchy_1 level 3',
   cust_touchpoint_lvl2_id             NUMBER                   COMMENT 'The identifier for customer touchpoint at hierarchy_1 level 2',
   cust_touchpoint_lvl3_name           VARCHAR(100)    NOT NULL COMMENT 'The textual name for customer touchpoint at hierarchy_1 level 3',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_CUSTOMER_TOUCHPOINT_LEVEL3 PRIMARY KEY (cust_touchpoint_lvl3_id)
)
COMMENT = 'This dimension defines different customer touchpoints by its hierarchy_1 level3(e.g. - Print Magazine, Mailings)';
