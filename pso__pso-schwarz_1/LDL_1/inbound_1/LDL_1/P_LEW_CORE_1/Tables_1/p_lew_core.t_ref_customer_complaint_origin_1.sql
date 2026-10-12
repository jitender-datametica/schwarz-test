CREATE TABLE p_lew_core.t_ref_customer_complaint_origin_1 (
	CUST_COMPLAINT_ORIGIN_CD VARCHAR(20) NOT NULL COMMENT 'A code for customer complaint  origin (Webform, etc)',
	CUST_COMPLAINT_ORIGIN_DESC VARCHAR(250) COMMENT 'A description for customer complaint  origin',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
	CONSTRAINT REF_BRAND_TYPE_PK PRIMARY KEY (CUST_COMPLAINT_ORIGIN_CD)
)COMMENT='Indicates how the customer complaint case was submited'
;