create or replace TABLE SZD_PRODUCTION.CORE_REL.T_LOT_DESTINATION_METRIC_2 (
	LOT_PRODUCT_INSTANCE_GROUP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the lot.',
	SHIPPING_DESTINATION_CD VARCHAR(50) NOT NULL COMMENT 'The code identifying a political country_2 according to ISO 3166.',
	METRIC_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'Type of the measure for lot ( for example BOOKED_PIECE_PER_CARTON, NOM_TOT_CARTON, ...)',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	UOM_CD VARCHAR(50) COMMENT 'The code identifying the unit_2 of measure.',
	METRIC_MEAS NUMBER(38,5) COMMENT 'Measure - Value of selected metrics for a lot',
	METRIC_QTY NUMBER(38,5) COMMENT 'Measure -Measure -Value of selected metrics for a lot (quantity)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	constraint PK_LOT_DESTINATION_METRIC primary key (LOT_PRODUCT_INSTANCE_GROUP_SID, METRIC_TYPE_CD, SHIPPING_DESTINATION_CD, DWH_VALID_FROM_TMSP)
)COMMENT='Satellite entity - A table that contains different measures and metric associated with lot - Source - VMT'
;