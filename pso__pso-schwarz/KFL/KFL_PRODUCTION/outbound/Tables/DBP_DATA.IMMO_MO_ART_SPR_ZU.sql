--==============================================================
-- Table: immo_mo_art_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_mo_art_spr_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_mo_art_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
mo_art_kz STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kennzeichen der Flächenart (Mietobjekt)'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
mo_art_bez STRING(40) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung der Flächenart (Mietobjekt) (z.B. Expansions-,Umbau-, Normalfläche etc.)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
)
OPTIONS(description='IMMO - Sprachabhängige Bezeichnung für die Flächenart (Mietobjekt) - SAP REFX - ZRE_FLAECHENARTT');