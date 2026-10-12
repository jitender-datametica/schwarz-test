--==============================================================
-- Table: markt_lagerbereich_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: markt_lagerbereich_spr_zu_1
   generated from Powerdesigner on Freitag, 28. März 2025 10:02:19
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.markt_lagerbereich_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
markt_lagerbereich_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Lagerbereichs in der Filiale.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der DWH-Sprache, z.B. 22 = Deutsch, 24 = Englisch, etc.'),
markt_lagerbereich_bez STRING(200) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Sprachabhängige Bezeichnung der Lagerbereichen in der Filiale.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, markt_lagerbereich_id, spr_id) NOT ENFORCED
)
OPTIONS(description='Diese Tabelle enthält die sprachabhänigige Bezeichnungen der Lagerbereichen in der Filiale. Wird manuell beladen.');