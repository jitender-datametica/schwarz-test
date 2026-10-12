--==============================================================
-- Table: rueckgabe_verwendung_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: rueckgabe_verwendung_spr_zu_1
   generated from Powerdesigner on Donnerstag, 1. Februar 2024 10:48:08
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.RUECKGABE_VERWENDUNG_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   rueckgabe_verwendung_kz             VARCHAR(10)      NOT NULL COMMENT 'Code definiert die Art_1 der Weiterverwendung eines in der Filiale zurück gegebenen Artikels. Die Weiterverwendung kann sich je nach Artikel_1 und Reklamationsgrund unterscheiden. Beispiele hierfür sind Abschreibungen, Qualitätssicherung, zurück in Verkauf, etc.',
   rueckgabe_verwendung_bez            VARCHAR(100)     NOT NULL COMMENT 'Bezeichnung der Art_1 der Weiterverwendung eines in der Filiale zurück gegebenen Artikels in unterschiedlichen Sprachen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_RUECKGABE_VERWENDUNG_SPR_ZU PRIMARY KEY (mandant_id, rueckgabe_verwendung_kz, spr_id) NOT ENFORCED
)  COMMENT = 'Sprachabhängige Bezeichnung der Arten der Weiterverwendung von zurück gegebenen Artikeln in Filialen.';
