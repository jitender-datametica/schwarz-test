CREATE TABLE p_lew_core.t_ref_customer_complaint_contact_type (
	CUST_COMPLAINT_CONTACT_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'A code for customer complaint type',
	CUST_COMPLAINT_CONTACT_TYPE_DESC VARCHAR(250) COMMENT 'A  customer complaint type ( Praise , Request , Criticism)',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
	CONSTRAINT REF_BRAND_TYPE_PK PRIMARY KEY (CUST_COMPLAINT_CONTACT_TYPE_CD)
)COMMENT='Indicates the mood of the customer in combination with the case ( Praise , Request , Criticism)'
;