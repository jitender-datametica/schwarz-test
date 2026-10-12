--==============================================================
-- Table: l_rueckgabe_verwendung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_rueckgabe_verwendung_2
   generated from Powerdesigner on Donnerstag, 1. Februar 2024 10:45:44
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_RUECKGABE_VERWENDUNG_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   rueckgabe_verwendung_kz             VARCHAR(10)      NOT NULL COMMENT 'Code definiert die Art_2 der Weiterverwendung eines in der Filiale zurück gegebenen Artikels. Die Weiterverwendung kann sich je nach Artikel_2 und Reklamationsgrund unterscheiden. Beispiele hierfür sind Abschreibungen, Qualitätssicherung, zurück in Verkauf, etc.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_RUECKGABE_VERWENDUNG PRIMARY KEY (mandant_id, rueckgabe_verwendung_kz) NOT ENFORCED
)  COMMENT = 'Tabelle beschreibt die unterschiedliche Arten der Weiterverwendung von zurück gegebenen Artikeln in den FIlialen. Diese können sich abhängig vom Artikel_2 und dem Grund der Reklamation unterscheiden.';