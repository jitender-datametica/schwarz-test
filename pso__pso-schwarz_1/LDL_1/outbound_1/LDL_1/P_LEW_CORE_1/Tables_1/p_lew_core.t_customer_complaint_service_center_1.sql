CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_customer_complaint_service_center_1 (
cust_complaint_srv_center_cd STRING(20) NOT NULL
OPTIONS(description='The code for the service center for proceeding customer complaint cases.'),
cust_complaint_srv_center_desc STRING(250)
OPTIONS(description='The description for the service center for proceeding customer complaint cases.'),
cust_complaint_bus_area_cd STRING(20)
OPTIONS(description='The code for the service area originating customer complaint cases'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (cust_complaint_srv_center_cd) NOT ENFORCED
)
OPTIONS(description=' Service center for proceeding customer complaint cases , Sometimes 2 countries are managed by same Service Country_1 Center.');