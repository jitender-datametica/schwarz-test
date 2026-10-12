CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_customer_complaint_metric_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
cal_dt DATE NOT NULL OPTIONS(description='WAWI: x_data.t_cal_calendarday.dat_calendar'),
cust_complaint_metric_type_cd STRING(20) NOT NULL
OPTIONS(description='Type of the measure for customer compaint case ( for example Total Number Of Calls )'),
cust_complaint_metric_measure NUMERIC(18,5)
OPTIONS(description='Value of selected metrics for customer complaint area on country_1 level'),
area_name STRING(100) NOT NULL
OPTIONS(description='A code for a business area to which metric is relevant. May represent a country_1 code or an area.'),
curr_sid BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key CURRENCY'),
cust_complaint_metric_local_val NUMERIC(18,5)
OPTIONS(description='Value of selected amount metrics for customer complaint area on country_1 level'),
cust_complaint_metric_eur_val NUMERIC(18,5)
OPTIONS(description='Value of selected amount metrics for customer complaint area on country_1 level in euro'),
cust_complaint_bus_area_cd STRING(20)
OPTIONS(description='The code for the service area originating customer complaint cases'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1 ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_1 angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (cal_dt, cust_complaint_metric_type_cd, area_name, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='A table to store different metrics associated with efficency of customer complaint metric');