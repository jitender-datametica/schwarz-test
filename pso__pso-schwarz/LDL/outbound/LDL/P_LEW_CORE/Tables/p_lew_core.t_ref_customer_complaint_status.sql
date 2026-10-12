CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_customer_complaint_status (
cust_complaint_status_cd STRING(250) NOT NULL
OPTIONS(description='Status code that uniqly identify customer case status ( assigned by DWH)'),
cust_complaint_status_desc STRING(250) OPTIONS(description='Status text Description'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (cust_complaint_status_cd) NOT ENFORCED
) OPTIONS(description='Customer Case status assigned to case (Waiting for Review, In Progress , Reopen , etc)');