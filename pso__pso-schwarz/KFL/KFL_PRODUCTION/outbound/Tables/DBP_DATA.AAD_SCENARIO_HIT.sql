--==============================================================
-- Table: aad_scenario_hit
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_scenario_hit
   generated from Powerdesigner on Mittwoch, 10. Mai 2023 08:35:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aad_scenario_hit (
scenario_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unique Identifier of the Scenario'),
bon_id STRING(100) NOT NULL OPTIONS(description='Eindeutige ID eines Bons, generierter Hashwert.'),
bon_dat DATE NOT NULL OPTIONS(description='Checkoutdatum, auch Businessday bzw. Kassenkey.'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprüft.'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH - ein Mandant pro Land.'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
bon_nr BIGNUMERIC(38,0)
OPTIONS(description='Die Bonnummer des Bons (ist eine fortlaufende Nummer die in der Kasse generiert wird, im Normalfall ist diese Nummer pro Tag und Kasse unique)'),
bon_booking DATETIME
OPTIONS(description='Buchungszeitpunkt des Bons, relevant z.Bsp. für artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine Kasse offline war.'),
kasse_nr BIGNUMERIC(38,0) OPTIONS(description='Nummer der Kasse.'),
hashed_cashier_id STRING(255) OPTIONS(description='Encrypted (hashed) Cashier ID'),
fraud_value_gross_local_val NUMERIC(18,4) OPTIONS(description='Amount of the fraud'),
dwh_created_tmsp DATETIME OPTIONS(description='Auto generate by Insert'),
dwh_updated_tmsp DATETIME OPTIONS(description='Auto generate by Update'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (scenario_id, bon_id, bon_dat, wup_id, mandant_id) NOT ENFORCED
) OPTIONS(description='Contains the scenario hits - a relationship between receipts and potential fraud scenario');