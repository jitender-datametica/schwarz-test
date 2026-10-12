--==============================================================
-- Table: l_rueckgabe_verwendung_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_rueckgabe_verwendung_1
   generated from Powerdesigner on Donnerstag, 1. Februar 2024 10:45:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_rueckgabe_verwendung_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
rueckgabe_verwendung_kz STRING(10) NOT NULL
OPTIONS(description='Code definiert die Art_1 der Weiterverwendung eines in der Filiale zurück gegebenen Artikels. Die Weiterverwendung kann sich je nach Artikel_1 und Reklamationsgrund unterscheiden. Beispiele hierfür sind Abschreibungen, Qualitätssicherung, zurück in Verkauf, etc.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, rueckgabe_verwendung_kz) NOT ENFORCED
)
OPTIONS(description='Tabelle beschreibt die unterschiedliche Arten der Weiterverwendung von zurück gegebenen Artikeln in den FIlialen. Diese können sich abhängig vom Artikel_1 und dem Grund der Reklamation unterscheiden.');