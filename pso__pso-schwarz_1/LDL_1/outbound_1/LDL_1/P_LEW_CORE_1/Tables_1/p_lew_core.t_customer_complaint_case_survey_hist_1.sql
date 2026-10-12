CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_customer_complaint_case_survey_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client_id ( constant value )'),
cust_complaint_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key for customer compaint case ( more granular )'),
cust_complaint_survey_dt STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Customer complainf feedback date'),
cust_complaint_feedback_val BIGNUMERIC(38,0) OPTIONS(description='A numeric feedback coming from customer feedback'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Datensatz ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_1 angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (cust_complaint_sid, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='A table to store customer complaint feedbacks');