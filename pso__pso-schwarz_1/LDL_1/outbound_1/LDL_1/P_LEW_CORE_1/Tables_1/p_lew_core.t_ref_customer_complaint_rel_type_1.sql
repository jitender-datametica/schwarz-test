CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_customer_complaint_rel_type_1 (
cust_complaint_rel_type_cd STRING(20) NOT NULL OPTIONS(description='Code: immutable representation of relation type;'),
cust_complaint_rel_type_desc STRING(100) NOT NULL OPTIONS(description='Description: updatable description.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (cust_complaint_rel_type_cd) NOT ENFORCED
) OPTIONS(description='Customer Complaint relation type');