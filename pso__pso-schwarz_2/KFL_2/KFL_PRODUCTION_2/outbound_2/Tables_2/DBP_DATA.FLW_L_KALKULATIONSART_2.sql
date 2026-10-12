--==============================================================
-- Table: flw_l_kalkulationsart_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_kalkulationsart_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_kalkulationsart_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
kalkulationsart_id STRING(2) NOT NULL
OPTIONS(description='ID der Kalkulationsart aus kalka. Schlüssel, der die interne Steuerung der Kalkulationsanwendung steuert (Bezugsobjekt z.B. Material, Musterkalkulation, Auftrag, Projekt). Die Kalkulationsart wird in der Kalkulationsvariante hinterlegt.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kalkulationsart_id) NOT ENFORCED
) OPTIONS(description='FLW - Lookup der Kalkulationsart - SAP P21 TCK02');