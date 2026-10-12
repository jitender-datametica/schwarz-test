CREATE TABLE CORE.T_DIM_TRAVEL_BOOKING_SERVICE_TYPE_1 (
   trav_booking_svc_type_cd            VARCHAR(20)      NOT NULL COMMENT 'The code for the booking service type ( TOUR_1 - Pauschalreise  , CRUISE - Kreuzfahrt etc )',
   trav_booking_svc_type_descr         VARCHAR(250)    NOT NULL COMMENT 'A textual description for the travel booking sevice type.',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_TRAVEL_BOOKING_SERVICE_TYPE PRIMARY KEY (trav_booking_svc_type_cd)
)
COMMENT = 'This minor dimension defines the travel booking leg type ( TOUR_1 - Pauschalreise  , CRUISE - Kreuzfahrt etc )';
