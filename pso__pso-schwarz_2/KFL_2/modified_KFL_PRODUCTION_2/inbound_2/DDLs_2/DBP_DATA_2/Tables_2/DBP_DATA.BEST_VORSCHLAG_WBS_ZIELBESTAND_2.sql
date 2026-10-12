--==============================================================
-- Table: best_vorschlag_wbs_zielbestand_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: best_vorschlag_wbs_zielbestand_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:16 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BEST_VORSCHLAG_WBS_ZIELBESTAND_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   aktion_id                           VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige Kennung einer Aktion_2 aus der Quelle wakh.aktnr',
   dat_bedarf_von                      DATE             NOT NULL COMMENT 'Datum Beginn Bedarfsperiode',
   dat_bedarf_bis                      DATE             NOT NULL COMMENT 'Datum Ende Bedarfsperiode',
   dat_letzte_nachversorgung           DATE             NOT NULL COMMENT 'Datum für den letzten Nachversorgungtag',
   zielendbestand_bme                  NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Zielendbestand für Austrittszeitpunkt in der WBS-Periode',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BEST_VORSCHLAG_WBS_ZIELBESTAND PRIMARY KEY (mandant_id, wup_id, art_id, nb_id, aktion_id) NOT ENFORCED
)  COMMENT = 'Tabelle zur Speicherung der Zielendbestände. Der Zielendbestand ist die erwartete Menge nach dem Ende der Werbenachversorgung.';

