--==============================================================
-- Table: rueckgabe_verwendung_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: rueckgabe_verwendung_spr_zu
   generated from Powerdesigner on Donnerstag, 1. Februar 2024 10:48:08
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rueckgabe_verwendung_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
rueckgabe_verwendung_kz STRING(10) NOT NULL
OPTIONS(description='Code definiert die Art der Weiterverwendung eines in der Filiale zurück gegebenen Artikels. Die Weiterverwendung kann sich je nach Artikel und Reklamationsgrund unterscheiden. Beispiele hierfür sind Abschreibungen, Qualitätssicherung, zurück in Verkauf, etc.'),
rueckgabe_verwendung_bez STRING(100) NOT NULL
OPTIONS(description='Bezeichnung der Art der Weiterverwendung eines in der Filiale zurück gegebenen Artikels in unterschiedlichen Sprachen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, rueckgabe_verwendung_kz, spr_id) NOT ENFORCED
)
OPTIONS(description='Sprachabhängige Bezeichnung der Arten der Weiterverwendung von zurück gegebenen Artikeln in Filialen.');