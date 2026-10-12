--==============================================================
-- Table: flw_handling_unit_det
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_handling_unit_det
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_handling_unit_det (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
handling_unit_id INTEGER NOT NULL OPTIONS(description='Interne Handling Unit Nummer aus Feld VENUM'),
handling_unit_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Handling Unit Position aus Feld VEPOS'),
anz_verk_menge_einh BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Packhilfsmittel (Verkaufsmengeneinheit) in der HU-Position aus Feld VEANZ'),
verk_menge_einh_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Verkaufsmengeneinheit aus Feld ZZVRKME'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, handling_unit_id, handling_unit_pos_id) NOT ENFORCED
) OPTIONS(description='FLW - Verpacken: Handling Unit Position (Inhalt) - SAP FLW (P21) - VEPO');