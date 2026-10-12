CREATE TABLE p_lew_core.t_ref_customer_complaint_category_1 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
	CUST_COMPLAINT_CAT_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key for category',
	CUST_COMPLAINT_SRV_CENTER_CD VARCHAR(20) COMMENT 'The code for the service center for proceeding customer complaint cases.',
	SRC_CUST_COMPLAINT_CAT_NR VARCHAR(50) NOT NULL COMMENT 'Customer Category number',
	CUST_COMPLAINT_CAT_NR VARCHAR(50) NOT NULL COMMENT 'Customer Category number',
	CUST_COMPLAINT_CAT_NAME VARCHAR(250) COMMENT 'Customer Category Name',
	SRC_NAME VARCHAR(100) COMMENT 'Source System Name ( Salesforce or BSI )',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
	CONSTRAINT REF_BRAND_TYPE_PK PRIMARY KEY (CUST_COMPLAINT_CAT_SID)
)COMMENT='Customer Case category assigned to case'
;