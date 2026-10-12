CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_customer_complaint_service_area_1 (
cust_complaint_srv_area_cd STRING(20) NOT NULL
OPTIONS(description='The code for the service area originating customer complaint cases.'),
cust_complaint_srv_area_desc STRING(250)
OPTIONS(description='The description for the  service area originating  customer complaint cases.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (cust_complaint_srv_area_cd) NOT ENFORCED
)
OPTIONS(description=' Service area originating customer complaint cases , Sometimes 2 area are managed by same Service Country_1 Center.');