create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_LOGISTIC_VARIANT_SIZE_1 (
	PROD_VARIANT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for a logistic variant of a product.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	LENGTH_MEAS NUMBER(38,5) COMMENT 'The length of the logistic variant, expressed in the indicated unit_1 of measure.',
	WIDTH_MEAS NUMBER(38,5) COMMENT 'The width of the logistic variant, expressed in the indicated unit_1 of measure.',
	HEIGHT_MEAS NUMBER(38,5) COMMENT 'The height of the logistic variant, expressed in the indicated unit_1 of measure.',
	SIZE_UOM_CD VARCHAR(20) COMMENT 'The code identifying the unit_1 of measure for the length, width and height.',
	NET_WEIGHT_MEAS NUMBER(38,5) COMMENT 'The net weight (i.e. excluding packing material) of the logistic variant, expressed in the indicated unit_1 of measure.',
	GROSS_WEIGHT_MEAS NUMBER(38,5) COMMENT 'The gross weight (i.e. including packing material) of the logistic variant, expressed in the indicated unit_1 of measure.',
	WEIGHT_UOM_CD VARCHAR(20) COMMENT 'The code identifying the unit_1 of measure.',
	UNITS_PER_PALLET_CNT NUMBER(38,0) COMMENT 'The number of logistic variants which can be packed on a pallet. (The type of pallet is indicated by the Pallet Type Code.)',
	UNITS_PER_PALLET_LAYER_CNT NUMBER(38,0) COMMENT 'The number of logistic variants which can be packed on one layer of a pallet. (The type of pallet is indicated by the Pallet Type Code.)',
	PALLET_TYPE_CD VARCHAR(20) COMMENT 'The code identifying the kind of pallet. (Euro-pallet vs. Duesseldorfer pallet)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_LOGISTIC_VARIANT_SIZE primary key (PROD_VARIANT_SID, DWH_VALID_FROM_TMSP)
)COMMENT='This entity tracks the physical size and weight of a logistic variant.'
;