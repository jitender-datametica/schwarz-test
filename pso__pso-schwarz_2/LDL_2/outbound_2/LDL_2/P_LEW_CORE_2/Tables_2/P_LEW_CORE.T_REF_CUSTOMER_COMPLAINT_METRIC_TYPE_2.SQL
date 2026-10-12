CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_customer_complaint_metric_type_2 (
cust_complaint_metric_type_cd STRING(20) NOT NULL
OPTIONS(description='Type of the measure for customer compaint case ( for example Total Number Of Calls )'),
cust_complaint_metric_type_desc STRING(100) NOT NULL
OPTIONS(description='Type of the measure for customer compaint case ( for example Total Number Of Calls )'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (cust_complaint_metric_type_cd) NOT ENFORCED
) OPTIONS(description='A reference table to store the description of available customer complaint metrics.');