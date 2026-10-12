/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_BUSINESS_EVENT_TYPE
   GENERATED FROM POWERDESIGNER ON Mittwoch, 29. Juni 2022 13:34:37
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_BUSINESS_EVENT_TYPE (
   BUSINESS_EVENT_TYPE_CD              VARCHAR(5)      NOT NULL COMMENT 'Code identifying the retail business event type  ( ex. O = Order, R = return ...)',
   BUSINESS_EVENT_TYPE_DESCR           VARCHAR(250)    COMMENT 'Textual description of the event type that leads to profit or loss',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   CONSTRAINT PK_T_DIM_BUSINESS_EVENT_TYPE PRIMARY KEY (BUSINESS_EVENT_TYPE_CD) NOT ENFORCED
 )  COMMENT= 'A minor dimension that contains type of events in the retail business ( "Order" , "Return") ';