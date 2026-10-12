create or replace TABLE SZD_PRODUCTION.CORE_REL.T_CONTAINER_SHIPMENT_MILESTONE_2 (
	CONTAINER_RESOURCE_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the container.',
	CONTAINER_MILESTONE_CD VARCHAR(50) NOT NULL COMMENT 'A milestone is an event in the container lifecycle. Table contains the list of the possible events',
	EVENT_TMSP TIMESTAMP_TZ(9) NOT NULL COMMENT 'The timestamp when the event took place',
	EVENT_DT DATE NOT NULL COMMENT 'A date when measurement was taken',
	MILESTONE_DT DATE COMMENT 'Descriptive Attribute - Business date of a milestone (e.g. date when gas measurement was done)',
	DUE_DT DATE COMMENT 'Descriptive Attribute - Due date of a milestone',
	DONE_DT DATE COMMENT 'Descriptive Attribute - Done date of milestone (date when system receives the data)',
	CONTAINER_MILESTONE_RESULT_EVALUATION_DT DATE COMMENT 'Descriptive Attribute - Event Result represented as a date',
	CONTAINER_MILESTONE_RESULT_EVALUATION_TXT VARCHAR(1000) COMMENT 'Descriptive Attribute -Text Description of Event Result',
	CONTAINER_MILESTONE_RESULT_CD VARCHAR(50) COMMENT 'A milestone is an event in the container lifecycle. Table contains the list of the possible event results',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	constraint PK_CONTAINER_SHIPMENT_MILESTONE primary key (CONTAINER_RESOURCE_ITEM_SID, EVENT_TMSP, CONTAINER_MILESTONE_CD)
)COMMENT='Entity - Transactional - Transaction - Containers start existing when the actual time of shipment (\"ATD\") is near. Then, the producer enters container numbers and their content to the lots'' container load plan. Containers have individual milestones, too. When all container milestones of a type are resolved, this may trigger the according lot milestone. For example, if all containers are unloaded, the lots'' unloading milestone state changes to resolved  - Source - VMT\n             '
;