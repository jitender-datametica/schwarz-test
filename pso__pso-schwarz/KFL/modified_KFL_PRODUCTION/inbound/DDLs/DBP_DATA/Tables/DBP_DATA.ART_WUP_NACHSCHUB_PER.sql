--==============================================================
-- Table: art_wup_nachschub_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_nachschub_per
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_WUP_NACHSCHUB_PER (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat_von                             DATE             NOT NULL COMMENT 'Datum gültig ab -  im Format JJJJ-MM-TT',
   dat_bis                             DATE             COMMENT 'Datum gültig bis - m Format JJJJ-MM-TT',
   menge_bestand_soll_max              NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Maximaler Sollbestand (PRWOG)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_WUP_NACHSCHUB_PER PRIMARY KEY (mandant_id, art_id, wup_id, nb_id, dat_von) NOT ENFORCED
)  COMMENT = 'LIS - Nachschub: Mengen pro Kunde/Artikel (tagesaktuell) - SAP RET - Tabelle WRPL';

