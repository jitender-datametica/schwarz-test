CREATE   TABLE p_lew_core.t_ref_customer_complaint_rel_type (
	CUST_COMPLAINT_REL_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'Code: immutable representation of relation type;',
	CUST_COMPLAINT_REL_TYPE_DESC VARCHAR(100) NOT NULL COMMENT 'Description: updatable description.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
	CONSTRAINT REF_ITEM_REL_TYPE_PK PRIMARY KEY (CUST_COMPLAINT_REL_TYPE_CD)
)COMMENT='Customer Complaint relation type'
;