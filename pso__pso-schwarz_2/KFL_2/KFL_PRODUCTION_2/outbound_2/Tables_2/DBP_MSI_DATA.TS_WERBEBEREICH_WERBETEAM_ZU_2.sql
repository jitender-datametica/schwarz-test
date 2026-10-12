--==============================================================
-- Table: ts_werbebereich_werbeteam_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_werbebereich_werbeteam_zu_2
   generated from Powerdesigner on Freitag, 11. Oktober 2024 15:09:43
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ts_werbebereich_werbeteam_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe.'),
werbebereich_cd STRING(100) OPTIONS(description='Code des Werbebereichs.'),
werbeteam_cd STRING(100) OPTIONS(description='Code des Werbeteams'),
werbeteam_bez STRING(100) OPTIONS(description='Werbeteam - Bezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wg_id) NOT ENFORCED
) OPTIONS(description='Transaktionservice Tabelle mit Informationen über Werbebereich und Werbeteam einer Warengruppe.');