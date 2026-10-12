--==============================================================
-- Table: fw_we_artikel_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fw_we_artikel_spr_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:44 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fw_we_artikel_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
fw_we_artikel_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID für die Kennzeichnung Fleischwerk WE-Artikel_2 aus dem Quellfeld zfwprzuber'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
fw_we_artikel_bez STRING(30) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung für das Artikelkennzeichen Fleischwerk WE-Artikel_2  aus dem Quellfeld Text, z.Bsp. Eigenproduktion'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wg_id, arthiertyp_id, spr_id) NOT ENFORCED
)
OPTIONS(description='FLW - Sprachabhängige Bezeichnungen der Fleischwerk WE-Artikel_2 Artikelkennzeichen aus der Retail Tabelle  zfwprzuber');