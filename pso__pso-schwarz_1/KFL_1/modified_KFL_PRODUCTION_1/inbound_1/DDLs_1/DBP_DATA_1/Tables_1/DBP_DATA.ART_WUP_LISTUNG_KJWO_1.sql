--==============================================================
-- Table: art_wup_listung_kjwo_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_listung_kjwo_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_WUP_LISTUNG_KJWO_1 CLUSTER BY (
     MANDANT_ID,
     KJWO 
) (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   wg_id                               INTEGER     NOT NULL COMMENT 'ID der Warengruppe',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   kjwo                                INTEGER     NOT NULL COMMENT 'Kalenderjahreswoche, Format JJJJWW',
   kreistyp_gruppe_id                  VARCHAR(4)       COLLATE 'en-ci' COMMENT 'Region_1 / Gruppierung Kreistypen',
   listung_id                          INTEGER     COMMENT 'kennzeichnet die Zulistung eines Artikels zum Markt: 1 = gelistet, 0 = nicht mehr gelistet. Der erste Eintrag erfolgt immer aufgrund einer Listung, bei Auslistung erfolgt  ein weiterer Eintrag mit 0. Die column ist wegen art_list_wup_zu_per_1 eigentlich obsolet',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_WUP_LISTUNG_KJWO PRIMARY KEY (mandant_id, art_id, wg_id, wup_id, nb_id, kjwo) NOT ENFORCED
)  COMMENT = 'AIS - Artikellistung pro Markt / Kalenderwoche';

