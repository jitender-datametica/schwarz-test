--==============================================================
-- Table: fw_wk_system_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fw_wk_system_spr_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fw_wk_system_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
fw_wk_system_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID des Fleischwerk WK Artikelkennzeichens aus zzfwbeschaf, z.Bsp. Innereien'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
fw_wk_system_bez STRING(30) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung für den Artikelkennzeichen Fleischwerk WK-System z.Bsp. Rindfleisch aus text'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wg_id, arthiertyp_id, spr_id) NOT ENFORCED
)
OPTIONS(description='FLW - Sprachabhängige Bezeichnungen für Fleischwer WK Artikelkennzeichen aus der Retail Tabelle zfwwprbesch             ');