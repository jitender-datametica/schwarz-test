CREATE TABLE CORE.T_FACT_TRAVEL_BOOKING_PASSENGER_2 (
   TRAV_BOOKING_SID                    NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the booking',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   PASSENGER_SALUTATION                VARCHAR(100)    COMMENT 'Passenger salutation',
   PASSENGER_FULL_NAME                 VARCHAR(100)    NOT NULL COMMENT 'Passenger full name ',
   PASSENGER_BIRTH_YEAR                NUMBER          NOT NULL COMMENT 'Passenger birth year ( 0 if it could not be identified)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME  VARCHAR(100) COMMENT 'The name of the source tables',
   BOOKING_NR                          VARCHAR(20)     COMMENT 'Unique Booking ID.',
   PROCESS_NR                          VARCHAR(20)     COMMENT 'Unique process ID. Process ID indicates the connection of different services (eg. Travel & insurance booking)',
   CONSTRAINT PK_T_FACT_TRAVEL_BOOKING_PASSE PRIMARY KEY (TRAV_BOOKING_SID, DWH_VALID_FROM_TMSP, PASSENGER_FULL_NAME, PASSENGER_BIRTH_YEAR)
       NOT ENFORCED
)
COMMENT = 'A fact containing passengers list for a particular booking'
DATA_RETENTION_TIME_IN_DAYS = 7
;