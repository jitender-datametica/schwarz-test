CREATE TABLE p_lew_core.t_customer_complaint_case_metric (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'Client_id ( constant value )',
   cust_complaint_sid                  NUMBER(38,0)    NOT NULL COMMENT 'Surrogate Key for customer compaint case',
   cust_complaint_metric_type_cd       VARCHAR(20)     NOT NULL COMMENT 'Type of the measue for customer compaint case ( for example Total Number Of Calls )',
   cust_complaint_metric_measure      NUMBER(38,0)    COMMENT 'Value of selected metrics for customer compaint case',
   deleted_fg                          NUMBER(38,0)    NOT NULL COMMENT 'Datensatz ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status angenommen',
   dwh_valid_from                      DATE            NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE            NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT MDM_ITEM_RELATED_ITEM_HIST_PK PRIMARY KEY (cust_complaint_sid, cust_complaint_metric_type_cd, dwh_valid_from)
       NOT enforced
)COMMENT = 'A table to store different metrics associated with customer case';