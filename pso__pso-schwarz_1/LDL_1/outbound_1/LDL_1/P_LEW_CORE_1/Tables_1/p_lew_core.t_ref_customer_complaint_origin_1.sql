CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_customer_complaint_origin_1 (
cust_complaint_origin_cd STRING(20) NOT NULL OPTIONS(description='A code for customer complaint  origin (Webform, etc)'),
cust_complaint_origin_desc STRING(250) OPTIONS(description='A description for customer complaint  origin'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (cust_complaint_origin_cd) NOT ENFORCED
) OPTIONS(description='Indicates how the customer complaint case was submited');