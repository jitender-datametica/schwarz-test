CREATE TABLE CORE.T_DIM_TRAVEL_BOOKING_DISTRIBUTION_SYSTEM_2 (
   trav_booking_dist_sys_cd            VARCHAR(5)      NOT NULL COMMENT 'The code for the general distribution system',
   trav_booking_dist_sys_descr         VARCHAR(250)    NOT NULL COMMENT 'A textual description for the general distribution system',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_TRAVEL_BOOKING_DISTRIBUTION_SYSTEM PRIMARY KEY (trav_booking_dist_sys_cd)
)
COMMENT = 'This minor dimension defines Identification of General Distribution System (Traffics/Traveltainment)';
