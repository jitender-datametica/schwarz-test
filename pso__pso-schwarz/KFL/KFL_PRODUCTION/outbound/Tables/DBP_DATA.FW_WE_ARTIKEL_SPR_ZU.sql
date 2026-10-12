--==============================================================
-- Table: fw_we_artikel_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fw_we_artikel_spr_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:44 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fw_we_artikel_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
fw_we_artikel_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID für die Kennzeichnung Fleischwerk WE-Artikel aus dem Quellfeld zfwprzuber'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache            '),
fw_we_artikel_bez STRING(30) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung für das Artikelkennzeichen Fleischwerk WE-Artikel  aus dem Quellfeld Text, z.Bsp. Eigenproduktion'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wg_id, arthiertyp_id, spr_id) NOT ENFORCED
)
OPTIONS(description='FLW - Sprachabhängige Bezeichnungen der Fleischwerk WE-Artikel Artikelkennzeichen aus der Retail Tabelle  zfwprzuber');