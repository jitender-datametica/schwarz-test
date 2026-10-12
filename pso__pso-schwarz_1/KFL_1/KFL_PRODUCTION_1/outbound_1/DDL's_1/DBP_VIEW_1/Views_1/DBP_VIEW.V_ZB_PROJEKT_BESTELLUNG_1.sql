CREATE OR REPLACE VIEW kfl_production_dbp_view.v_zb_projekt_bestellung_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'),
bestell_beleg_nr OPTIONS(description='Belegnummer der Bestellung.'), dat_erstellung
OPTIONS(description='Erstelldatum der Bestellung.'), gp_id
OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'), einkaufsorganisation_id
OPTIONS(description='ID der Einkaufsorganisation aus ekorg'))
OPTIONS(DESCRIPTION = `Enhält die erstellten Bestellungen (Kopfinformationen), die innerhalb von Projekten aus den Zentralbereichen erstellt werden.`)
AS SELECT mandant_id,
 bestell_beleg_nr,
 dat_erstellung,
 gp_id,
 einkaufsorganisation_id
FROM kfl_production_dbp_data.zb_projekt_bestellung_1;