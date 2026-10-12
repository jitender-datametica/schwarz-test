CREATE TABLE p_lew_core.t_customer_complaint_metric_2 (
client_id                           NUMBER(38,0)    NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
cal_dt                              DATE            NOT NULL COMMENT 'WAWI: x_data.t_cal_calendarday.dat_calendar',
cust_complaint_metric_type_cd       VARCHAR(20)     NOT NULL COMMENT 'Type of the measure for customer compaint case ( for example Total Number Of Calls )',
cust_complaint_metric_measure       NUMBER(18,5)    COMMENT 'Value of selected metrics for customer complaint area on country_2 level',
area_name                           VARCHAR(100)    NOT NULL COMMENT 'A code for a business area to which metric is relevant. May represent a country_2 code or an area.',
curr_sid                            NUMBER(38,0)    COMMENT 'Surrogate Key CURRENCY',
cust_complaint_metric_local_val     NUMBER(18,5)    COMMENT 'Value of selected amount metrics for customer complaint area on country_2 level',
cust_complaint_metric_eur_val       NUMBER(18,5)    COMMENT 'Value of selected amount metrics for customer complaint area on country_2 level in euro',
cust_complaint_bus_area_cd          VARCHAR(20)     COMMENT 'The code for the service area originating customer complaint cases',
deleted_fg                          NUMBER(38,0)    NOT NULL COMMENT 'Artikel_2 ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_2 angenommen',
dwh_valid_from                      DATE            NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
dwh_valid_to                        DATE            NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
CONSTRAINT model_run_metric_pk PRIMARY KEY (cal_dt, cust_complaint_metric_type_cd, area_name, dwh_valid_from) NOT ENFORCED
) COMMENT = 'A table to store different metrics associated with efficency of customer complaint metric'
;