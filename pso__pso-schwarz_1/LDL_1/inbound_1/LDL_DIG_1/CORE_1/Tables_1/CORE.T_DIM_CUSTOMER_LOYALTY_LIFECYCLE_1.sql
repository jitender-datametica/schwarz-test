/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CUSTOMER_LOYALTY_LIFECYCLE_1
   GENERATED FROM POWERDESIGNER ON Freitag, 24. Mai 2024 16:15:13
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CUSTOMER_LOYALTY_LIFECYCLE_1 (
   CUST_LOYALTY_LIFECYCLE_CD           VARCHAR(5)      NOT NULL COMMENT 'The code that defines the loyalty lifecycle of the customer.',
   CUST_LOYALTY_LIFECYCLE_DESCR        VARCHAR(250)    NOT NULL COMMENT 'The description for the code that defines the loyalty lifecycle of the customer.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_DIM_CUSTOMER_LOYALTY_LIFECYCLE PRIMARY KEY (CUST_LOYALTY_LIFECYCLE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - This dimension defines the loyalty lifecycle of the customer based on the time interval between two consecutive orders i.e.
             New Customer (NC) = 2nd last order was placed more than 3 years ago or is non-existent.
             Reactivated Customer (RC) = 2nd last order was placed more than 1 year ago, but less than 3 years ago.
             Existing Customer (EC) = 2nd last order was placed less than 1 year ago (more than 1 order in the past year).
             
             ';
