CREATE TABLE CORE.T_DIM_TRAVEL_BOOKING_ROOM_TYPE_2 (
	TRAV_BOOKING_ROOM_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The unique code for the room type',
	TRAV_BOOKING_ROOM_TYPE_DESCR VARCHAR(250) COMMENT 'A textual description for room type',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	TRAV_BOOKING_ROOM_TYPE_GROUP_CD VARCHAR(50) COMMENT 'The code for the grouping of room type (Double, Single)',
    DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
    SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_TRAVEL_BOOKING_ROOM_TYPE PRIMARY KEY (TRAV_BOOKING_ROOM_TYPE_CD)
       NOT ENFORCED
   )COMMENT='This minor dimension defines the room type codes(DB H, APX1). Because of different sources may be different from the one in travel offer'
;