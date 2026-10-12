--==============================================================
-- Table: art_art_nielsen_matching_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_art_nielsen_matching_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_ART_NIELSEN_MATCHING_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   art_nielsen_id                      INTEGER     NOT NULL COMMENT 'Artikel_1-ID aus Nielsen',
   gtin_id                             INTEGER     NOT NULL COMMENT 'Global Trade Item_1 Number (GTIN)',
   art_matching_id                     INTEGER     COMMENT 'Gruppierungskriterium für Artikel_1 (kann auch nur ein Artikel_1 sein), die über die GTIN zu Nielsen-Artikel_1 gematched werden',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_ART_NIELSEN_MATCHING_ZU PRIMARY KEY (mandant_id, art_id, art_nielsen_id) NOT ENFORCED
)  COMMENT = 'EK-INT - Mappingtabelle Nielsen-Artikel_1 zu  Kaufland Artikel_1';

