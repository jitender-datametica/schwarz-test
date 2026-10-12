--==============================================================
-- Table: flw_transport_hu_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_transport_hu_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:40 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_transport_hu_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
tour_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='LKW-Nummer (eind.Schlüssel) aus Feld LKW_NUM'),
handling_unit_id_ext STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Externe Handling Unit_1 Identifikation aus Feld NVE'),
verlade_lief_beleg_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Verladelieferschein Nummer aus Feld ZZVLSNUM'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, tour_id) NOT ENFORCED
) OPTIONS(description='FLW - LKW-Positionsdaten (Transport) - SAP FLW (P21) - ZFW_TR_POS');