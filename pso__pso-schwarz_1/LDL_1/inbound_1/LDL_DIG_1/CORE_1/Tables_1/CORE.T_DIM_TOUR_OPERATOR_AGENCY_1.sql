CREATE TABLE CORE.T_DIM_TOUR_OPERATOR_AGENCY_1 (
   tour_operator_agency_cd             VARCHAR(100)    NOT NULL COMMENT 'The code for identifying tour_1 operator agency code',
   tour_operator_cd                    VARCHAR(50)     COMMENT 'The unique code for identifying tour_1 operator',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_TOUR_OPERATOR_AGENCY PRIMARY KEY (tour_operator_agency_cd)
)
COMMENT = 'This minor dimension defines the tour_1 operator agency details (there can be many tour_1 operator agency code or no agency code under one tour_1 operator code)';