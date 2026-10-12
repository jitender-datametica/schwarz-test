--==============================================================
-- Table: art_kreistyp_gruppe_wup_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_kreistyp_gruppe_wup_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_KREISTYP_GRUPPE_WUP_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   kreistyp_gruppe_id                  VARCHAR(4)       COLLATE 'en-ci' COMMENT 'Region / Gruppierung Kreistypen',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_KREISTYP_GRUPPE_WUP_ZU PRIMARY KEY (mandant_id, wup_id, nb_id, art_id) NOT ENFORCED
)  COMMENT = 'AIS - Zuordnungstabelle Artikel-Markt zu kreistyp_gruppe';

