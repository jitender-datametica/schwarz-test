--==============================================================
-- Table: flw_kalkulationsart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_kalkulationsart_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_kalkulationsart_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
kalkulationsart_id STRING(2) NOT NULL
OPTIONS(description='ID der Kalkulationsart aus kalka. Schlüssel, der die interne Steuerung der Kalkulationsanwendung steuert (Bezugsobjekt z.B. Material, Musterkalkulation, Auftrag, Projekt). Die Kalkulationsart wird in der Kalkulationsvariante hinterlegt.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
kalkulationsart_bez STRING(30) DEFAULT ' ' NOT NULL OPTIONS(description='Bezeichnung der Kalkulationsart aus txlka'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kalkulationsart_id, spr_id) NOT ENFORCED
) OPTIONS(description='FLW - Sprachabhängige Bezeichnung der Kalkulationsart - SAP P21 TCK02');