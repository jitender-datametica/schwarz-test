/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_TRAVEL_BOOKING_FEE_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 22. August 2023 16:32:19
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_TRAVEL_BOOKING_FEE_1 (
   BOSKEY_ID                           VARCHAR(100)    NOT NULL COMMENT 'Unique booking identifier in bosys API.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid (Timestamp of last process update ).',
   LAST_PROCESS_UPDATE_TMSP            TIMESTAMP_TZ    NOT NULL COMMENT 'The point in time when this record became valid (Timestamp of last process update ).',
   TRAV_BOOKING_SID                    NUMBER          COMMENT 'The unique identifier (surrogate key) for the booking',
   PROCESS_NR                          VARCHAR(20)     COMMENT 'Unique process ID. Process ID indicates the connection of different services (eg. Travel & insurance booking)',
   BOOKING_NR                          VARCHAR(20)     COMMENT 'Unique Booking ID.',
   TRAV_BOOKING_COUPON_CD              VARCHAR(25)     COMMENT 'The codes that customer entered during booking process to activate Coupon.( examples 3001, 3002, etc)',
   COUPON_PRICE_VAL                    NUMBER(38, 5)   COMMENT 'Value of a coupon a customer used for booking a travel. In the data sample of Bosys the value can be identified with the attribute "Preis" in combination with "Type". It is only then a voucher if "type"=fee. All other characterizations of type are related to services (fligth/tour_1/...)',
   TRAV_BOOKING_COUPON_CUST_CD         VARCHAR(100)    COMMENT 'The codes that customer entered during booking process to activate Coupon.( examples 3001, 3002, etc)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_ETL_TRAVEL_BOOKING_FEE PRIMARY KEY (LAST_PROCESS_UPDATE_TMSP, DWH_VALID_FROM_TMSP, BOSKEY_ID) NOT ENFORCED
 )  COMMENT= 'This ETL table contains detailed fee data for a booking and offers high granularity by adding the bosys id. It is used to help loading data into T_FACT_TRAVEL_BOOKING_1, specially for the FEE';
