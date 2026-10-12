--==============================================================
-- Table: art_art_nielsen_matching_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_art_nielsen_matching_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_ART_NIELSEN_MATCHING_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   art_nielsen_id                      NUMBER(38,0)     NOT NULL COMMENT 'Artikel-ID aus Nielsen',
   gtin_id                             NUMBER(26,0)     NOT NULL COMMENT 'Global Trade Item Number (GTIN)',
   art_matching_id                     NUMBER(38,0)     COMMENT 'Gruppierungskriterium für Artikel (kann auch nur ein Artikel sein), die über die GTIN zu Nielsen-Artikel gematched werden',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_ART_NIELSEN_MATCHING_ZU PRIMARY KEY (mandant_id, art_id, art_nielsen_id) NOT ENFORCED
)  COMMENT = 'EK-INT - Mappingtabelle Nielsen-Artikel zu  Kaufland Artikel';

