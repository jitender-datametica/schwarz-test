/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_PASSENGER_TYPE_CLUSTER_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 25. Oktober 2022 10:38:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_PASSENGER_TYPE_CLUSTER_1 (
   PASSENGER_TYPE_CLUSTER_CD           VARCHAR(25)     NOT NULL COMMENT 'The code for the categorization of passanger based on their age and gender ( Single traveler , Small Family , etc)',
   PASSENGER_TYPE_CLUSTER_DESCR        VARCHAR(250)    NOT NULL COMMENT 'A textual description for thecategorization of passanger based on their age and gender ( Single traveler , Small Family , etc)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_PASSENGER_TYPE_CLUSTER PRIMARY KEY (PASSENGER_TYPE_CLUSTER_CD) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the categorization of passanger based on their age and gender ( Single traveler , Small Family , etc)';
