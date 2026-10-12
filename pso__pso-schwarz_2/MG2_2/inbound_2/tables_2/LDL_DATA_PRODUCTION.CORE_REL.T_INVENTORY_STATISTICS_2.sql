create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_INVENTORY_STATISTICS_2 (
	INV_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the inventory event.',
	INV_STAT_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the kind of stasticis value that is calculated for an inventory.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	INV_STAT_VAL NUMBER(38,5) COMMENT 'The calculated statistics measure for the given inventory event, expressed as an amount in the indicated currency.',
	CURR_CD VARCHAR(3) COMMENT 'The code identifying the currency, according to ISO 4217.',
	INV_STAT_CNT NUMBER(38,0) COMMENT 'The calculated statistics measure for the given inventory event, expressed as a count.',
	INV_STAT_QTY NUMBER(38,5) COMMENT 'The calculated statistics measure for the given inventory event, expressed as a quantity.',
	INV_STAT_PCT NUMBER(38,5) COMMENT 'The calculated statistics measure for the given inventory event, expressed as a percentage.',
	INV_STAT_MEAS NUMBER(38,5) COMMENT 'The calculated statistics measure for the given inventory event, expressed in the indicated unit_2 of measure.',
	UOM_CD VARCHAR(20) COMMENT 'The code identifying the unit_2 of measure.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_INVENTORY_STATISTICS primary key (INV_SID, INV_STAT_TYPE_CD, DWH_VALID_FROM_TMSP)
)COMMENT='Various statistics can be calculated as part of the inventory process, such as the total value of the counted products, the related turnover in the inventory period or the inventory difference (i.e. the difference to the calculated stock). The kind of statistics is defined by the statistics type code. The statistics values do not necessarily need to be in sync with the base values.'
;