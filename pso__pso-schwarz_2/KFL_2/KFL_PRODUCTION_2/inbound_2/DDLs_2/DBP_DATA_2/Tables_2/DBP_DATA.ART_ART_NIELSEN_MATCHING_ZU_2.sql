--==============================================================
-- Table: art_art_nielsen_matching_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_art_nielsen_matching_zu_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_ART_NIELSEN_MATCHING_ZU_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   art_nielsen_id                      NUMBER(38,0)     NOT NULL COMMENT 'Artikel_2-ID aus Nielsen',
   gtin_id                             NUMBER(26,0)     NOT NULL COMMENT 'Global Trade Item_2 Number (GTIN)',
   art_matching_id                     NUMBER(38,0)     COMMENT 'Gruppierungskriterium für Artikel_2 (kann auch nur ein Artikel_2 sein), die über die GTIN zu Nielsen-Artikel_2 gematched werden',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_ART_NIELSEN_MATCHING_ZU PRIMARY KEY (mandant_id, art_id, art_nielsen_id) NOT ENFORCED
)  COMMENT = 'EK-INT - Mappingtabelle Nielsen-Artikel_2 zu  Kaufland Artikel_2';

