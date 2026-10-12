--==============================================================
-- Table: flw_handling_unit_det_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_handling_unit_det_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_handling_unit_det_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
handling_unit_id INTEGER NOT NULL OPTIONS(description='Interne Handling Unit_1 Nummer aus Feld VENUM'),
handling_unit_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Handling Unit_1 Position aus Feld VEPOS'),
anz_verk_menge_einh BIGNUMERIC(38,0)
OPTIONS(description='Anzahl Packhilfsmittel (Verkaufsmengeneinheit) in der HU-Position aus Feld VEANZ'),
verk_menge_einh_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Verkaufsmengeneinheit aus Feld ZZVRKME'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, handling_unit_id, handling_unit_pos_id) NOT ENFORCED
) OPTIONS(description='FLW - Verpacken: Handling Unit_1 Position (Inhalt) - SAP FLW (P21) - VEPO');