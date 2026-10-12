--==============================================================
-- Table: rueckgabe_verwendung_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: rueckgabe_verwendung_spr_zu_1
   generated from Powerdesigner on Donnerstag, 1. Februar 2024 10:48:08
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rueckgabe_verwendung_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
rueckgabe_verwendung_kz STRING(10) NOT NULL
OPTIONS(description='Code definiert die Art_1 der Weiterverwendung eines in der Filiale zurück gegebenen Artikels. Die Weiterverwendung kann sich je nach Artikel_1 und Reklamationsgrund unterscheiden. Beispiele hierfür sind Abschreibungen, Qualitätssicherung, zurück in Verkauf, etc.'),
rueckgabe_verwendung_bez STRING(100) NOT NULL
OPTIONS(description='Bezeichnung der Art_1 der Weiterverwendung eines in der Filiale zurück gegebenen Artikels in unterschiedlichen Sprachen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, rueckgabe_verwendung_kz, spr_id) NOT ENFORCED
)
OPTIONS(description='Sprachabhängige Bezeichnung der Arten der Weiterverwendung von zurück gegebenen Artikeln in Filialen.');