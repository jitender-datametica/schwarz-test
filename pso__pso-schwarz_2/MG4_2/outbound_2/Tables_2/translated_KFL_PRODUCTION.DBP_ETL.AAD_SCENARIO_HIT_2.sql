CREATE OR REPLACE TABLE kfl_production_dbp_etl.aad_scenario_hit_2 (
scenario_id INTEGER NOT NULL OPTIONS(description='Unique Identifier of the Scenario'),
bon_id STRING(100) NOT NULL OPTIONS(description='Eindeutige ID eines Bons, generierter Hashwert.'),
bon_dat DATE NOT NULL OPTIONS(description='Checkoutdatum, auch Businessday bzw. Kassenkey.'),
wup_id INTEGER NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprüft.'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH - ein Mandant_2 pro Land.'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
bon_nr INTEGER
OPTIONS(description='Die Bonnummer des Bons (ist eine_2 fortlaufende Nummer die in der Kasse generiert wird, im Normalfall ist diese Nummer pro Tag_2 und Kasse unique)'),
bon_booking DATETIME
OPTIONS(description='Buchungszeitpunkt des Bons, relevant z.Bsp. für artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine_2 Kasse offline war.'),
kasse_nr INTEGER OPTIONS(description='Nummer der Kasse.'),
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