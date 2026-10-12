CREATE TABLE CORE.T_DIM_CUSTOMER_BOOKING_REFERENCE_1 (
   CUST_BOOKING_REF_SID                NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for customer booking reference link',
   CUST_BOOKING_REF_LINK               VARCHAR(1000)   NOT NULL COMMENT 'The reference link containing EKID & URL identifying the customer touch points incase of offline and online booking',
   CUST_TOUCHPOINT_LVL3_ID             NUMBER          NOT NULL COMMENT 'The identifier for customer touchpoint at hierarchy_1 level 3',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_CUSTOMER_BOOKING_REFERENCE PRIMARY KEY (CUST_BOOKING_REF_SID) NOT ENFORCED
 )  COMMENT= 'This dimension defines the different customer booking reference id. Contains EKID & URL identifying customer touchpoint incase of online and offline booking';
