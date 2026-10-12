create or replace TABLE SZD_PRODUCTION.CORE_REL.T_INVOICE_STATUS_1 (
	INVOICE_FINANCE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the invoice.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	INVOICE_STATUS_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The unique code of the invoice status_1 type.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_INVOICE_STATUS primary key (INVOICE_FINANCE_SID, DWH_VALID_FROM_TMSP)
)COMMENT='Entity - Transactional - Transaction - Contains the status_1 changes of an invoice. - Source - WWT'
;