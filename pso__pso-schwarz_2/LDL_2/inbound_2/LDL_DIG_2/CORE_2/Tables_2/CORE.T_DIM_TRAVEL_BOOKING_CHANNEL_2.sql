CREATE TABLE CORE.T_DIM_TRAVEL_BOOKING_CHANNEL_2 (
   trav_booking_channel_cd             VARCHAR(5)      NOT NULL COMMENT 'The code for the travel booking center.',
   trav_booking_channel_descr          VARCHAR(250)    NOT NULL COMMENT 'A textual description for the travel booking center.',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_TRAVEL_BOOKING_CHANNEL PRIMARY KEY (trav_booking_channel_cd)
)
COMMENT = 'This minor dimension defines the travel booking channel (offline/online)';
