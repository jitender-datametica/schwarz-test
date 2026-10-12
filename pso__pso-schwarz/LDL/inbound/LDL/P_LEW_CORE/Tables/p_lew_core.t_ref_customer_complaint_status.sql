CREATE TABLE p_lew_core.t_ref_customer_complaint_status (
	CUST_COMPLAINT_STATUS_CD VARCHAR(250) NOT NULL COMMENT 'Status code that uniqly identify customer case status ( assigned by DWH)',
	CUST_COMPLAINT_STATUS_DESC VARCHAR(250) COMMENT 'Status text Description',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
	CONSTRAINT REF_BRAND_TYPE_PK PRIMARY KEY (CUST_COMPLAINT_STATUS_CD)
)COMMENT='Customer Case status assigned to case (Waiting for Review, In Progress , Reopen , etc)'
;