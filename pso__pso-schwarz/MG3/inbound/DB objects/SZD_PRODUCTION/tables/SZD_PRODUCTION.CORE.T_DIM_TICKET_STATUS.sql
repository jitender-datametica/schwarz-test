create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_TICKET_STATUS (
	TICKET_STATUS_ID NUMBER(38,0) NOT NULL COMMENT 'The code identifying the discriminators for tickets status',
	TICKET_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'The code identifying the discriminators for ticket types.',
	TICKET_STATUS_CD VARCHAR(50) NOT NULL COMMENT 'Natural Key/Business Key - The code identifying the discriminators for tickets status',
	TICKET_STATUS_NAME VARCHAR(100) NOT NULL COMMENT 'A textual description for the discriminators for tickets status',
	TICKET_STATUS_NAME_EN VARCHAR(100) NOT NULL COMMENT 'A textual description for the discriminators for tickets status. Language english',
	TICKET_STATUS_NAME_DE VARCHAR(100) NOT NULL COMMENT 'A textual description for the discriminators for tickets status. Language german',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOB storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_DIM_TICKET_STATUS primary key (TICKET_STATUS_ID)
)COMMENT='Minor Dimension - defines the discriminators for tickets status. Possible status: Open / Work in progress / Waiting - wait for external oder wait for enduser / Comped / Closed. Source - IT4You Service Now'
;