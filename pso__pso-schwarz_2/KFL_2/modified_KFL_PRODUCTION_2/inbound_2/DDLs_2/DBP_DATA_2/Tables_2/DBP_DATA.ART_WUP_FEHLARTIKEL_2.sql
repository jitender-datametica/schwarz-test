--==============================================================
-- Table: art_wup_fehlartikel_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_fehlartikel_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_WUP_FEHLARTIKEL_2 (
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat_letzter_we                      DATE             NOT NULL COMMENT 'Datum des letzten Wareneingangs',
   dat_letzter_umsatz                  DATE             COMMENT 'Datum letzter Umsatz',
   fehlartikel_kz                      INTEGER     NOT NULL COMMENT 'Kennzeichen, ob Fehlartikel. Ausprägungen: Fehlartikel ja, Fehlartikel nein, nicht relevant',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_WUP_FEHLARTIKEL PRIMARY KEY (art_id, mandant_id, wup_id, nb_id) NOT ENFORCED
)  COMMENT = 'VIS - abgeleitete Tabelle zur Ermittlung der Fehlartikel, innerhalb des DWH versorgt';

