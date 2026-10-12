CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_customer_complaint_case_related_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client_id ( constant value )'),
cust_complaint_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key for customer compaint case ( more granular )'),
cust_complaint_rel_type_cd STRING(20) NOT NULL,
cust_complaint_sid_related BIGNUMERIC(38,0)
OPTIONS(description='Surrogate Key for related customer compaint case ( less granular )'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Datensatz ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_2 angenommen'),
main_cust_complaint_status_cd STRING(250)
OPTIONS(description='Status_2 code that uniqly identify customer case status_2 on a merge date ( assigned by DWH)'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (cust_complaint_sid, cust_complaint_rel_type_cd, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='A table to store main case - subcase  , parent-child and other types of relantionships for complaint cases');