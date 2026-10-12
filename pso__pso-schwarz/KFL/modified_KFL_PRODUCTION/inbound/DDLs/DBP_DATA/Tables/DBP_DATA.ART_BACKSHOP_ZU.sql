--==============================================================
-- Table: art_backshop_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_backshop_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_BACKSHOP_ZU (
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   bestell_art_id                      INTEGER     NOT NULL COMMENT 'Bestellartikel = ein Artikel der WG 291, der nicht verkauft wird, sondern lediglich zur Produktion eines anderen Artikels dient. Referenz zur Tabelle art',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_BACKSHOP_ZU PRIMARY KEY (art_id, mandant_id, bestell_art_id) NOT ENFORCED
)  COMMENT = 'VIS Backshop -Zuordnung der Backshop-Verkaufsartikel zu den Backshop-Bestellartikeln';

