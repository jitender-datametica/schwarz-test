create or replace TABLE SZD_PRODUCTION.ETL.T_ETL_FACT_RVM_DELIVERY_STATUS_1 (
	RVM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the despotie machine which is located in a store',
	RVM_PROCESSING_DT DATE NOT NULL COMMENT 'The date when the reports are processed',
	RVM_REPORT_DT DATE NOT NULL COMMENT 'The date of the source report file',
	RVM_LAST_SEND_DT DATE COMMENT 'The last sent date captured from the deposit receipt',
	RVM_DELIVERY_STATUS VARCHAR(250) NOT NULL COMMENT 'The delivery status_1 of the deposit machine (e.g.ok,Nachlieferung,Neue Lieferung.. )',
	DIFF_IN_DAYS_CNT NUMBER(38,0) COMMENT 'The date interval between the last send date and the processing date',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	constraint PK_T_FACT_RVM_DELIVERY_STATUS primary key (RVM_SID, RVM_PROCESSING_DT, RVM_REPORT_DT)
);