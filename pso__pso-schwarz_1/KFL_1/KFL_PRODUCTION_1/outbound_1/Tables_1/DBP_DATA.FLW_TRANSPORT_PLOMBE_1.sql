--==============================================================
-- Table: flw_transport_plombe_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_transport_plombe_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:40 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_transport_plombe_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
tour_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='LKW-Nummer (eind.Schlüssel) aus Feld LKW_NUM'),
plombe_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Plombennummer aus Feld PLO_NR'),
dat_plombe_aenderung DATE NOT NULL OPTIONS(description='Zeitstempel Änderung Plombennummer aus Feld CREADAT'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, tour_id, plombe_id) NOT ENFORCED
) OPTIONS(description='FLW - Zuordnung von Plomben zum LKW - SAP FLW (P21) - ZFW_TR_PLO');