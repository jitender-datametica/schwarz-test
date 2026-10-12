--==============================================================
-- Table: fw_wk_national_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fw_wk_national_spr_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:44 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fw_wk_national_spr_zu_2 (
fw_wk_national_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung aus text, z.Bsp. Renner Ost'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
fw_wk_national_bez STRING(50) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung für den Artikelkennzeichen Fleischwerk WK-National z.Bsp. Renner West aus text'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wg_id, arthiertyp_id, spr_id) NOT ENFORCED
)
OPTIONS(description='FLW - Sprachabhängige Bezeichnungen der Fleischwerk WK  National Artikelkennzeichen aus der Retail Tabelle  zfwprwaren             ');