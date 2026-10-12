create or replace TABLE SZD_PRODUCTION.ETL.T_ETL_DIM_TICKET_CLOSING_REASON_2 (
	TICKET_CLOSING_REASON_ID NUMBER(38,0) NOT NULL COMMENT 'The code identifying the discriminators for ticket closing reasons',
	TICKET_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'The code identifying the discriminators for ticket types.',
	TICKET_CLOSING_REASON_CD VARCHAR(50) NOT NULL COMMENT 'Natural Key/Business Key - A code for the discriminators for ticket closing reasons. Possible values: Article available in Servicecatalog, Duplicate Ticket, Knowledge trasfer to user, Non-IT Reason, Request cancelled by user, Request completed successully, Declined, CBBC for Rückruf vor Abschluss. In some cases also numbered codes',
	TICKET_CLOSING_REASON_NAME VARCHAR(100) NOT NULL COMMENT 'A textual description for the discriminators for ticket closing reasons. Possible values: Article available in Servicecatalog, Duplicate Ticket, Knowledge trasfer to user, Non-IT Reason, Request cancelled by user, Request completed successully, Declined',
	TICKET_CLOSING_REASON_NAME_EN VARCHAR(100) NOT NULL COMMENT 'A textual description for the discriminators for ticket closing reasons. Possible values: Article available in Servicecatalog, Duplicate Ticket, Knowledge trasfer to user, Non-IT Reason, Request cancelled by user, Request completed successully, Declined',
	TICKET_CLOSING_REASON_NAME_DE VARCHAR(100) NOT NULL COMMENT 'A textual description for the discriminators for ticket closing reasons. Possible values: Article available in Servicecatalog, Duplicate Ticket, Knowledge trasfer to user, Non-IT Reason, Request cancelled by user, Request completed successully, Declined',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_DIM_TICKET_CLOSING_REASON primary key (TICKET_CLOSING_REASON_ID)
);