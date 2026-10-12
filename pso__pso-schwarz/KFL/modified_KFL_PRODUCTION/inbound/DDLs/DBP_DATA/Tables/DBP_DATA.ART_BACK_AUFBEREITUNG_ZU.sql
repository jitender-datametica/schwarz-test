--==============================================================
-- Table: art_back_aufbereitung_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_back_aufbereitung_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_BACK_AUFBEREITUNG_ZU (
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   back_aufbereitung_id                INTEGER     NOT NULL COMMENT 'eindeutige ID der Back-Aufbereitung aus dem Quellfeld ID, z.Bsp. 1',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_BACK_AUFBEREITUNG_ZU PRIMARY KEY (art_id, mandant_id, back_aufbereitung_id) NOT ENFORCED
)  COMMENT = 'VIS Backshop - Zuordnung von Aufbereitungsanweisungen  zu Artikeln';

