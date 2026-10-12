--==============================================================
-- Table: art_back_aufbereitung_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_back_aufbereitung_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_BACK_AUFBEREITUNG_ZU_1 (
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   back_aufbereitung_id                INTEGER     NOT NULL COMMENT 'eindeutige ID der Back-Aufbereitung aus dem Quellfeld ID, z.Bsp. 1',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_BACK_AUFBEREITUNG_ZU PRIMARY KEY (art_id, mandant_id, back_aufbereitung_id) NOT ENFORCED
)  COMMENT = 'VIS Backshop - Zuordnung von Aufbereitungsanweisungen  zu Artikeln';

