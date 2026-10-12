--==============================================================
-- Table: fw_saison_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fw_saison_spr_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:44 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fw_saison_spr_zu (
fw_saison_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID für das  Fleischwerk-Artikel-Kennzeichen Saison aus dem Quellfeld zfwprartik'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
fw_saison_bez STRING(30) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung für den Artikelblock, z.Bsp. Rindfleisch aus text'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wg_id, arthiertyp_id, spr_id) NOT ENFORCED
)
OPTIONS(description='FLW -Sprachbhängige Bezeichnungen für Fleischwerk-Saison-Artikelkennzeichnung  aus der Retail Tabelle zzfwprartik');