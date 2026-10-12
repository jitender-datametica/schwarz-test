create or replace TABLE SZD_PRODUCTION.CORE_REL.T_LOT_SHIPMENT_MILESTONE_1 (
	LOT_PRODUCT_INSTANCE_GROUP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the lot.',
	LOT_MILESTONE_CD VARCHAR(50) NOT NULL COMMENT 'A milestone is an event in the lot lifecycle. Table contains the list of the possible events',
	EVENT_TMSP TIMESTAMP_TZ(9) NOT NULL COMMENT 'The timestamp when the event took place',
	EVENT_DT DATE NOT NULL COMMENT 'A date when measurement was taken',
	MILESTONE_DT DATE COMMENT 'Descriptive Attribute - Business date of a milestone (e.g. date when gas measurement was done)',
	DUE_DT DATE COMMENT 'Descriptive Attribute - Due date of a milestone',
	DONE_DT DATE COMMENT 'Descriptive Attribute - Done date of milestone (date when system receives the data)',
	LOT_MILESTONE_RESULT_EVALUATION_DT DATE COMMENT 'Descriptive Attribute - Event Result represented as a date',
	LOT_MILESTONE_RESULT_EVALUATION_TXT VARCHAR(1000) COMMENT 'Descriptive Attribute - Text  Description of Lot Event Result',
	LOT_MILESTONE_RESULT_CD VARCHAR(50) COMMENT 'A milestone is an event in the lot lifecycle. Table contains the list of the possible events',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	constraint PK_LOT_SHIPMENT_MILESTONE primary key (LOT_PRODUCT_INSTANCE_GROUP_SID, EVENT_TMSP, LOT_MILESTONE_CD)
)COMMENT='Entity - Transactional - Transaction - A milestone is an event in the lot lifecycle. There are around 60 milestones in VMT such as \"shipment release\" or \"producer booking\". Some milestones are triggered by external events/interfaces, others resolved by manual actions - Source - VMT'
;