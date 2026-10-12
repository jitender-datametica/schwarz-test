CREATE TABLE p_lew_core.t_customer_complaint_service_center_1 (
   cust_complaint_srv_center_cd        VARCHAR(20)     NOT NULL COMMENT 'The code for the service center for proceeding customer complaint cases.',
   cust_complaint_srv_center_desc      VARCHAR(250)    COMMENT 'The description for the service center for proceeding customer complaint cases.',
   cust_complaint_bus_area_cd          VARCHAR(20)     COMMENT 'The code for the service area originating customer complaint cases',
   dwh_valid_from                      DATE            NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE            NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT BRAND_PK PRIMARY KEY (cust_complaint_srv_center_cd)
       NOT ENFORCED
)COMMENT = ' Service center for proceeding customer complaint cases , Sometimes 2 countries are managed by same Service Country_1 Center.';