CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_customer_complaint_category (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
cust_complaint_cat_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key for category'),
cust_complaint_srv_center_cd STRING(20)
OPTIONS(description='The code for the service center for proceeding customer complaint cases.'),
src_cust_complaint_cat_nr STRING(50) NOT NULL OPTIONS(description='Customer Category number'),
cust_complaint_cat_nr STRING(50) NOT NULL OPTIONS(description='Customer Category number'),
cust_complaint_cat_name STRING(250) OPTIONS(description='Customer Category Name'),
src_name STRING(100) OPTIONS(description='Source System Name ( Salesforce or BSI )'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (cust_complaint_cat_sid) NOT ENFORCED
) OPTIONS(description='Customer Case category assigned to case');