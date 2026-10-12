/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CUSTOMER_GENERATION_1
   GENERATED FROM POWERDESIGNER ON Montag, 20. November 2023 08:42:04
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CUSTOMER_GENERATION_1 (
   CUST_GENERATION_CD                  VARCHAR(50)     NOT NULL COMMENT 'The code for a customer generation',
   CUST_GENERATION_DESCR               VARCHAR(250)    COMMENT 'The textual description for the generation of a customer ',
   GENERATION_START_CY                 NUMBER          COMMENT 'Calendar_1 year for a start of generation',
   GENERATION_END_CY                   NUMBER          COMMENT 'Calendar_1 year for an end of generation',
   DISPLAY_ORDER_NR                    NUMBER          COMMENT 'Display order number for a generation list to appear in front end',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_CUSTOMER_GENERATION PRIMARY KEY (CUST_GENERATION_CD) NOT ENFORCED
 )  COMMENT= 'This dimension contains a list of generations for customer segmentation ( Generation Alpha , Generation X etc )';
