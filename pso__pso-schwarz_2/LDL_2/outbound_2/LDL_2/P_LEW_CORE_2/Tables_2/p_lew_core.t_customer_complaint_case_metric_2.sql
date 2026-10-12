CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_customer_complaint_case_metric_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client_id ( constant value )'),
cust_complaint_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key for customer compaint case'),
cust_complaint_metric_type_cd STRING(20) NOT NULL
OPTIONS(description='Type of the measue for customer compaint case ( for example Total Number Of Calls )'),
cust_complaint_metric_measure BIGNUMERIC(38,0)
OPTIONS(description='Value of selected metrics for customer compaint case'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Datensatz ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_2 angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (cust_complaint_sid, cust_complaint_metric_type_cd, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='A table to store different metrics associated with customer case');