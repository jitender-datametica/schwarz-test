--==============================================================
-- Table: art_wup_nachschub_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_nachschub_per_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_WUP_NACHSCHUB_PER_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat_von                             DATE             NOT NULL COMMENT 'Datum gültig ab -  im Format JJJJ-MM_2-TT',
   dat_bis                             DATE             COMMENT 'Datum gültig bis - m Format JJJJ-MM_2-TT',
   menge_bestand_soll_max              NUMBER(18,3)     NOT NULL DEFAULT 0 COMMENT 'Maximaler Sollbestand (PRWOG)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_WUP_NACHSCHUB_PER PRIMARY KEY (mandant_id, art_id, wup_id, nb_id, dat_von) NOT ENFORCED
)  COMMENT = 'LIS - Nachschub: Mengen pro Kunde/Artikel_2 (tagesaktuell) - SAP RET - Tabelle WRPL';

