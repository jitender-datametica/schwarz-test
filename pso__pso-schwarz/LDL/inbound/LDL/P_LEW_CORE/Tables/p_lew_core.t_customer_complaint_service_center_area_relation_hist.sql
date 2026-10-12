CREATE TABLE p_lew_core.t_customer_complaint_service_center_area_relation_hist (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'Surrogate Key CLIENT',
   cust_complaint_srv_center_cd        VARCHAR(20)     NOT NULL COMMENT 'The code for the service center for proceeding customer complaint cases.',
   cust_complaint_srv_area_cd          VARCHAR(20)     NOT NULL COMMENT 'The code for the service area originating customer complaint cases.',
   deleted_fg                          NUMBER(38,0)    NOT NULL COMMENT 'Artikel ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status angenommen',
   dwh_valid_from                      DATE            NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE            NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT BRAND_PK PRIMARY KEY (client_id, dwh_valid_from, cust_complaint_srv_center_cd, cust_complaint_srv_area_cd)
       NOT enforced
)COMMENT = ' Service center for proceeding customer complaint cases , Sometimes 2 countries are managed by same Service Country Center.';