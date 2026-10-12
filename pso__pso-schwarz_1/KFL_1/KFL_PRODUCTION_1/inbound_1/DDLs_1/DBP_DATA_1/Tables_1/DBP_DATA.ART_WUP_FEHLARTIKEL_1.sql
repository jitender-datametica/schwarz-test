--==============================================================
-- Table: art_wup_fehlartikel_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_fehlartikel_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_WUP_FEHLARTIKEL_1 (
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat_letzter_we                      DATE             NOT NULL COMMENT 'Datum des letzten Wareneingangs',
   dat_letzter_umsatz                  DATE             COMMENT 'Datum letzter Umsatz',
   fehlartikel_kz                      NUMBER(38,0)     NOT NULL COMMENT 'Kennzeichen, ob Fehlartikel. Ausprägungen: Fehlartikel ja, Fehlartikel nein, nicht relevant',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_WUP_FEHLARTIKEL PRIMARY KEY (art_id, mandant_id, wup_id, nb_id) NOT ENFORCED
)  COMMENT = 'VIS - abgeleitete Tabelle zur Ermittlung der Fehlartikel, innerhalb des DWH versorgt';

