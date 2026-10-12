CREATE TABLE CORE.T_DIM_TRAVEL_BOOKING_SERVICE_STATUS_2 (
   trav_booking_svc_status_cd          VARCHAR(5)      NOT NULL COMMENT 'The code for the status_2 of  travel  service ( c-open,  b-booking , etc )',
   trav_booking_svc_status_descr       VARCHAR(250)    NOT NULL COMMENT 'A textual description for the status_2 of travel service',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_TRAVEL_BOOKING_SERVICE_STATUS PRIMARY KEY (trav_booking_svc_status_cd)
)
COMMENT = 'This minor dimension defines the status_2 of booking service';