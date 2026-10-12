--==============================================================
-- Table: l_rueckgabe_verwendung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_rueckgabe_verwendung_2
   generated from Powerdesigner on Donnerstag, 1. Februar 2024 10:45:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_rueckgabe_verwendung_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
rueckgabe_verwendung_kz STRING(10) NOT NULL
OPTIONS(description='Code definiert die Art_2 der Weiterverwendung eines in der Filiale zurück gegebenen Artikels. Die Weiterverwendung kann sich je nach Artikel_2 und Reklamationsgrund unterscheiden. Beispiele hierfür sind Abschreibungen, Qualitätssicherung, zurück in Verkauf, etc.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, rueckgabe_verwendung_kz) NOT ENFORCED
)
OPTIONS(description='Tabelle beschreibt die unterschiedliche Arten der Weiterverwendung von zurück gegebenen Artikeln in den FIlialen. Diese können sich abhängig vom Artikel_2 und dem Grund der Reklamation unterscheiden.');