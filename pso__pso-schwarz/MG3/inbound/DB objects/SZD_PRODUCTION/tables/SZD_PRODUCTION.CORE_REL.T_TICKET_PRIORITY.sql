create or replace TABLE SZD_PRODUCTION.CORE_REL.T_TICKET_PRIORITY (
	TICKET_PRIORITY_ID NUMBER(38,0) NOT NULL COMMENT 'The code identifying the discriminators for tickets priority.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	UNIT_ID NUMBER(38,0) NOT NULL COMMENT 'Id of the unit (e.g. material unit, production line parameter)',
	TICKET_PRIORITY_CD VARCHAR(50) NOT NULL COMMENT 'Natural Key/Business Key - The code  identifying the discriminators for priority (e.g. Prio number for INC & PRB, urgency in days for NSR)',
	TICKET_PRIORITY_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the discriminators for priority',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_TICKET_PRIORITY primary key (TICKET_PRIORITY_ID, LANG_CD)
)COMMENT='Minor Entity - defines the discriminators for priority like prio, urgency, precedency for any kind of objects e.g. tickets, contracts, events. Source - Source - IT4You Service Now'
;