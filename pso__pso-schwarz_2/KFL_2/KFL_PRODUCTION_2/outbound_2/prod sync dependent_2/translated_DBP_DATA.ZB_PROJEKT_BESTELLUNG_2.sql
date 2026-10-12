CREATE OR REPLACE TABLE kfl_production_dbp_data.zb_projekt_bestellung_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
bestell_beleg_nr INTEGER NOT NULL OPTIONS(description='Belegnummer der Bestellung.'),
dat_erstellung DATE NOT NULL OPTIONS(description='Erstelldatum der Bestellung.'),
gp_id INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
einkaufsorganisation_id INTEGER OPTIONS(description='ID der Einkaufsorganisation aus ekorg'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, bestell_beleg_nr) NOT ENFORCED
)
OPTIONS(description='Enhält die erstellten Bestellungen (Kopfinformationen), die innerhalb von Projekten aus den Zentralbereichen erstellt werden.');